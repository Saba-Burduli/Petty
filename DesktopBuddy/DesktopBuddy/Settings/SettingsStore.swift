import AppKit

final class SettingsStore {
    private enum Key {
        static let characterOriginX = "characterOriginX"
        static let characterOriginY = "characterOriginY"
        static let alwaysOnTop = "alwaysOnTop"
    }

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        defaults.register(defaults: [Key.alwaysOnTop: true])
    }

    var characterOrigin: NSPoint? {
        get {
            guard defaults.object(forKey: Key.characterOriginX) != nil,
                  defaults.object(forKey: Key.characterOriginY) != nil else {
                return nil
            }
            return NSPoint(
                x: defaults.double(forKey: Key.characterOriginX),
                y: defaults.double(forKey: Key.characterOriginY)
            )
        }
        set {
            guard let newValue else {
                defaults.removeObject(forKey: Key.characterOriginX)
                defaults.removeObject(forKey: Key.characterOriginY)
                return
            }
            defaults.set(newValue.x, forKey: Key.characterOriginX)
            defaults.set(newValue.y, forKey: Key.characterOriginY)
        }
    }

    var alwaysOnTop: Bool {
        get { defaults.bool(forKey: Key.alwaysOnTop) }
        set { defaults.set(newValue, forKey: Key.alwaysOnTop) }
    }
}
