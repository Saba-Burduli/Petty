import AppKit

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    private let settingsStore = SettingsStore()
    private let stateManager = CharacterStateManager()
    private var characterWindowController: CharacterWindowController?
    private var menuBarController: MenuBarController?
    private var activityMonitor: ActivityMonitor?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)

        let windowController = CharacterWindowController(
            stateManager: stateManager,
            settingsStore: settingsStore
        )
        characterWindowController = windowController

        menuBarController = MenuBarController(
            characterWindowController: windowController,
            settingsStore: settingsStore
        )

        activityMonitor = ActivityMonitor { [weak stateManager] idleSeconds in
            stateManager?.update(idleSeconds: idleSeconds)
        }

        windowController.show()
        activityMonitor?.start()
    }

    func applicationWillTerminate(_ notification: Notification) {
        activityMonitor?.stop()
        characterWindowController?.saveCurrentPosition()
    }
}
