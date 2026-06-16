import AppKit

final class SettingsStore: ObservableObject {
    private enum Key {
        static let characterOriginX = "characterOriginX"
        static let characterOriginY = "characterOriginY"
        static let alwaysOnTop = "alwaysOnTop"
        static let selectedCharacterID = "selectedCharacterID"
        static let characterScale = "characterScale"
    }

    private let defaults: UserDefaults

    @Published var alwaysOnTop: Bool {
        didSet { defaults.set(alwaysOnTop, forKey: Key.alwaysOnTop) }
    }

    @Published var selectedCharacterID: String {
        didSet { defaults.set(selectedCharacterID, forKey: Key.selectedCharacterID) }
    }

    @Published var characterScale: Double {
        didSet { defaults.set(characterScale, forKey: Key.characterScale) }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        defaults.register(defaults: [
            Key.alwaysOnTop: true,
            Key.selectedCharacterID: CharacterCatalog.assets[0].id,
            Key.characterScale: 1.0
        ])
        alwaysOnTop = defaults.bool(forKey: Key.alwaysOnTop)
        let savedCharacterID = defaults.string(forKey: Key.selectedCharacterID) ?? CharacterCatalog.assets[0].id
        selectedCharacterID = CharacterCatalog.assets.contains { $0.id == savedCharacterID } ? savedCharacterID : CharacterCatalog.assets[0].id
        characterScale = defaults.double(forKey: Key.characterScale)
        if characterScale == 0 {
            characterScale = 1.0
        }
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

}
