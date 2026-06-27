import SwiftUI

extension Notification.Name {
    static let openPettySettings = Notification.Name("com.sababurduli.Petty.openSettings")
}

@main
struct PettyApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
        .commands {
            CommandGroup(replacing: .appSettings) {
                Button("Store & Settings...") {
                    NotificationCenter.default.post(name: .openPettySettings, object: nil)
                }
                .keyboardShortcut(",", modifiers: .command)
            }
        }
    }
}
