import AppKit
import SwiftUI

final class CharacterWindowController: NSObject {
    private let stateManager: CharacterStateManager
    private let settingsStore: SettingsStore
    private let panelSize = NSSize(width: 150, height: 160)
    private var panel: NSPanel?

    init(stateManager: CharacterStateManager, settingsStore: SettingsStore) {
        self.stateManager = stateManager
        self.settingsStore = settingsStore
        super.init()
        createPanel()
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
            rootView: CharacterView(stateManager: stateManager),
            onDragBegan: { [weak self] in
                Task { @MainActor in self?.stateManager.beginDragging() }
            },
            onDragEnded: { [weak self] in
                Task { @MainActor in
                    self?.constrainToVisibleScreen()
                    self?.saveCurrentPosition()
                    self?.stateManager.endDragging()
                }
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
        let frame = NSRect(origin: origin, size: panelSize)
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
        return NSPoint(
            x: visibleFrame.maxX - panelSize.width - 48,
            y: visibleFrame.minY + 72
        )
    }
}

private final class DraggableHostingView<Content: View>: NSHostingView<Content> {
    private let onDragBegan: () -> Void
    private let onDragEnded: () -> Void
    private var dragStartMouseLocation: NSPoint?
    private var dragStartWindowOrigin: NSPoint?
    private var hasStartedDrag = false

    init(rootView: Content, onDragBegan: @escaping () -> Void, onDragEnded: @escaping () -> Void) {
        self.onDragBegan = onDragBegan
        self.onDragEnded = onDragEnded
        super.init(rootView: rootView)
    }

    required init(rootView: Content) {
        self.onDragBegan = {}
        self.onDragEnded = {}
        super.init(rootView: rootView)
    }

    @MainActor @preconcurrency required dynamic init?(coder: NSCoder) {
        nil
    }

    override func mouseDown(with event: NSEvent) {
        dragStartMouseLocation = NSEvent.mouseLocation
        dragStartWindowOrigin = window?.frame.origin
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
        let nextOrigin = NSPoint(
            x: startOrigin.x + currentMouse.x - startMouse.x,
            y: startOrigin.y + currentMouse.y - startMouse.y
        )
        window.setFrameOrigin(nextOrigin)
    }

    override func mouseUp(with event: NSEvent) {
        dragStartMouseLocation = nil
        dragStartWindowOrigin = nil
        if hasStartedDrag {
            onDragEnded()
        }
        hasStartedDrag = false
    }
}
