import AppKit
import SwiftUI

@MainActor
final class SettingsWindowController {
    private let settingsStore: SettingsStore
    private weak var characterWindowController: CharacterWindowController?
    private var window: NSWindow?

    init(settingsStore: SettingsStore, characterWindowController: CharacterWindowController) {
        self.settingsStore = settingsStore
        self.characterWindowController = characterWindowController
    }

    func show() {
        if window == nil {
            createWindow()
        }

        window?.center()
        window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    private func createWindow() {
        let view = SettingsView(
            settingsStore: settingsStore,
            onShow: { [weak self] in self?.characterWindowController?.show() },
            onHide: { [weak self] in self?.characterWindowController?.hide() },
            onResetPosition: { [weak self] in self?.characterWindowController?.resetPosition() }
        )

        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 520, height: 560),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        window.title = "Petty Store & Settings"
        window.contentView = NSHostingView(rootView: view)
        window.isReleasedWhenClosed = false
        self.window = window
    }
}
