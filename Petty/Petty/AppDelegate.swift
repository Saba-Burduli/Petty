import AppKit

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    private let settingsStore = SettingsStore()
    private let stateManager = CharacterStateManager()
    private var characterWindowController: CharacterWindowController?
    private var menuBarController: MenuBarController?
    private var settingsWindowController: SettingsWindowController?
    private var activityMonitor: ActivityMonitor?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)

        let windowController = CharacterWindowController(
            stateManager: stateManager,
            settingsStore: settingsStore
        )
        characterWindowController = windowController

        let settingsController = SettingsWindowController(
            settingsStore: settingsStore,
            characterWindowController: windowController
        )
        settingsWindowController = settingsController

        menuBarController = MenuBarController(
            characterWindowController: windowController,
            settingsStore: settingsStore,
            settingsWindowController: settingsController
        )

        activityMonitor = ActivityMonitor { [weak stateManager] activity in
            stateManager?.update(activity: activity)
        }

        windowController.show()
        activityMonitor?.start()
    }

    func applicationWillTerminate(_ notification: Notification) {
        activityMonitor?.stop()
        characterWindowController?.saveCurrentPosition()
    }
}
