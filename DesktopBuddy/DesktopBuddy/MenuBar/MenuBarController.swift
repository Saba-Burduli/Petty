import AppKit

final class MenuBarController: NSObject {
    private let statusItem: NSStatusItem
    private weak var characterWindowController: CharacterWindowController?
    private let settingsStore: SettingsStore

    init(characterWindowController: CharacterWindowController, settingsStore: SettingsStore) {
        self.characterWindowController = characterWindowController
        self.settingsStore = settingsStore
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        super.init()
        configureStatusItem()
        rebuildMenu()
    }

    private func configureStatusItem() {
        statusItem.button?.title = "Repz"
        statusItem.button?.toolTip = "DesktopBuddy"
    }

    private func rebuildMenu() {
        let menu = NSMenu()

        menu.addItem(NSMenuItem(title: "Show Character", action: #selector(showCharacter), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Hide Character", action: #selector(hideCharacter), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Reset Position", action: #selector(resetPosition), keyEquivalent: "r"))
        menu.addItem(NSMenuItem.separator())

        let alwaysOnTopItem = NSMenuItem(title: "Always On Top", action: #selector(toggleAlwaysOnTop), keyEquivalent: "")
        alwaysOnTopItem.state = settingsStore.alwaysOnTop ? .on : .off
        menu.addItem(alwaysOnTopItem)

        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit DesktopBuddy", action: #selector(quit), keyEquivalent: "q"))

        menu.items.forEach { $0.target = self }
        statusItem.menu = menu
    }

    @objc private func showCharacter() {
        characterWindowController?.show()
    }

    @objc private func hideCharacter() {
        characterWindowController?.hide()
    }

    @objc private func resetPosition() {
        characterWindowController?.resetPosition()
    }

    @objc private func toggleAlwaysOnTop() {
        characterWindowController?.alwaysOnTop.toggle()
        rebuildMenu()
    }

    @objc private func quit() {
        characterWindowController?.saveCurrentPosition()
        NSApp.terminate(nil)
    }
}
