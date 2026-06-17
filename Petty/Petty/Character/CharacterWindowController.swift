import AppKit
import Combine
import SwiftUI

final class CharacterWindowController: NSObject {
    private let stateManager: CharacterStateManager
    private let settingsStore: SettingsStore
    private var panel: NSPanel?
    private var cancellables = Set<AnyCancellable>()

    init(stateManager: CharacterStateManager, settingsStore: SettingsStore) {
        self.stateManager = stateManager
        self.settingsStore = settingsStore
        super.init()
        createPanel()
        observeSettings()
    }

    var isVisible: Bool {
        panel?.isVisible == true
    }

    var alwaysOnTop: Bool {
        get { settingsStore.alwaysOnTop }
        set {
            settingsStore.alwaysOnTop = newValue
            applyWindowLevel()
        }
    }

    func show() {
        guard let panel else { return }
        ensureVisibleFrame()
        panel.orderFrontRegardless()
    }

    func hide() {
        panel?.orderOut(nil)
    }

    func resetPosition() {
        guard let panel else { return }
        panel.setFrameOrigin(defaultOrigin())
        saveCurrentPosition()
        show()
    }

    func saveCurrentPosition() {
        guard let panel else { return }
        settingsStore.characterOrigin = panel.frame.origin
    }

    private func createPanel() {
        let panelSize = currentPanelSize()
        let origin = restoredOrigin() ?? defaultOrigin()
        let frame = NSRect(origin: origin, size: panelSize)
        let panel = NSPanel(
            contentRect: frame,
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )

        panel.isOpaque = false
        panel.backgroundColor = .clear
        panel.hasShadow = false
        panel.hidesOnDeactivate = false
        panel.isMovableByWindowBackground = false
        panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]

        let view = DraggableHostingView(
            rootView: CharacterView(stateManager: stateManager, settingsStore: settingsStore),
            onDragBegan: { [weak self] in
                Task { @MainActor in self?.stateManager.beginDragging() }
            },
            onDragChanged: { [weak self] pointsPerSecond in
                Task { @MainActor in self?.stateManager.updateDragSpeed(pointsPerSecond: pointsPerSecond) }
            },
            onDragEnded: { [weak self] in
                Task { @MainActor in
                    self?.constrainToVisibleScreen()
                    self?.saveCurrentPosition()
                    self?.stateManager.endDragging()
                }
            },
            onClick: { [weak self] in
                Task { @MainActor in self?.stateManager.poke() }
            }
        )
        view.frame = NSRect(origin: .zero, size: panelSize)
        panel.contentView = view

        self.panel = panel
        applyWindowLevel()
    }

    private func applyWindowLevel() {
        panel?.level = alwaysOnTop ? .floating : .normal
    }

    private func observeSettings() {
        settingsStore.$alwaysOnTop
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.applyWindowLevel()
            }
            .store(in: &cancellables)

        settingsStore.$characterScale
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.resizePanelForCurrentScale()
            }
            .store(in: &cancellables)
    }

    private func ensureVisibleFrame() {
        guard restoredOrigin() != nil else {
            resetPosition()
            return
        }
        constrainToVisibleScreen()
    }

    private func constrainToVisibleScreen() {
        guard let panel else { return }
        let currentFrame = panel.frame
        guard !isFrameVisible(currentFrame) else { return }
        panel.setFrameOrigin(defaultOrigin())
    }

    private func restoredOrigin() -> NSPoint? {
        guard let origin = settingsStore.characterOrigin else { return nil }
        let frame = NSRect(origin: origin, size: currentPanelSize())
        return isFrameVisible(frame) ? origin : nil
    }

    private func isFrameVisible(_ frame: NSRect) -> Bool {
        NSScreen.screens.contains { screen in
            screen.visibleFrame.intersects(frame)
        }
    }

    private func defaultOrigin() -> NSPoint {
        let screen = NSScreen.main ?? NSScreen.screens.first
        let visibleFrame = screen?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1440, height: 900)
        let panelSize = currentPanelSize()
        return NSPoint(
            x: visibleFrame.maxX - panelSize.width - 48,
            y: visibleFrame.minY + 72
        )
    }

    private func currentPanelSize() -> NSSize {
        let size = CharacterView.panelSize(for: settingsStore.characterScale)
        return NSSize(width: size.width, height: size.height)
    }

    private func resizePanelForCurrentScale() {
        guard let panel else { return }
        let oldFrame = panel.frame
        let newSize = currentPanelSize()
        guard oldFrame.size != newSize else { return }

        let newOrigin = NSPoint(
            x: oldFrame.midX - newSize.width / 2,
            y: oldFrame.minY
        )
        panel.setFrame(NSRect(origin: newOrigin, size: newSize), display: true)
        if let hostingView = panel.contentView {
            hostingView.frame = NSRect(origin: .zero, size: newSize)
        }
        constrainToVisibleScreen()
        saveCurrentPosition()
    }
}

private final class DraggableHostingView<Content: View>: NSHostingView<Content> {
    private let onDragBegan: () -> Void
    private let onDragChanged: (CGFloat) -> Void
    private let onDragEnded: () -> Void
    private let onClick: () -> Void
    private var dragStartMouseLocation: NSPoint?
    private var dragStartWindowOrigin: NSPoint?
    private var previousDragMouseLocation: NSPoint?
    private var previousDragTime: TimeInterval?
    private var hasStartedDrag = false

    init(rootView: Content, onDragBegan: @escaping () -> Void, onDragChanged: @escaping (CGFloat) -> Void, onDragEnded: @escaping () -> Void, onClick: @escaping () -> Void) {
        self.onDragBegan = onDragBegan
        self.onDragChanged = onDragChanged
        self.onDragEnded = onDragEnded
        self.onClick = onClick
        super.init(rootView: rootView)
    }

    required init(rootView: Content) {
        self.onDragBegan = {}
        self.onDragChanged = { _ in }
        self.onDragEnded = {}
        self.onClick = {}
        super.init(rootView: rootView)
    }

    @MainActor @preconcurrency required dynamic init?(coder: NSCoder) {
        nil
    }

    override func mouseDown(with event: NSEvent) {
        dragStartMouseLocation = NSEvent.mouseLocation
        dragStartWindowOrigin = window?.frame.origin
        previousDragMouseLocation = dragStartMouseLocation
        previousDragTime = event.timestamp
        hasStartedDrag = false
    }

    override func mouseDragged(with event: NSEvent) {
        guard let window, let startMouse = dragStartMouseLocation, let startOrigin = dragStartWindowOrigin else {
            return
        }

        if !hasStartedDrag {
            hasStartedDrag = true
            onDragBegan()
        }

        let currentMouse = NSEvent.mouseLocation
        if let previousMouse = previousDragMouseLocation, let previousTime = previousDragTime {
            let elapsed = max(event.timestamp - previousTime, 0.001)
            let distance = hypot(currentMouse.x - previousMouse.x, currentMouse.y - previousMouse.y)
            onDragChanged(distance / elapsed)
        }
        previousDragMouseLocation = currentMouse
        previousDragTime = event.timestamp

        let nextOrigin = NSPoint(
            x: startOrigin.x + currentMouse.x - startMouse.x,
            y: startOrigin.y + currentMouse.y - startMouse.y
        )
        window.setFrameOrigin(nextOrigin)
    }

    override func mouseUp(with event: NSEvent) {
        dragStartMouseLocation = nil
        dragStartWindowOrigin = nil
        previousDragMouseLocation = nil
        previousDragTime = nil
        if hasStartedDrag {
            onDragEnded()
        } else {
            onClick()
        }
        hasStartedDrag = false
    }
}
