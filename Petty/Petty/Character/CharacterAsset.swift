import Foundation

struct CharacterAsset: Identifiable, Equatable {
    let id: String
    let displayName: String
    let tagline: String
    let resourceFolder: String
    let resourceURL: URL?
    let source: String
    let sortOrder: Int
    let idleAnimation: CharacterAnimation
    let walkAnimation: CharacterAnimation
    let attackAnimation: CharacterAnimation
    let sleepAnimation: CharacterAnimation

    var previewAnimation: CharacterAnimation {
        idleAnimation
    }

    func animation(for state: CharacterState, activityKind: CharacterActivityKind, dragSpeed: CGFloat) -> CharacterAnimation {
        switch state {
        case .idle:
            return idleAnimation
        case .active:
            return walkAnimation.withSpeed(activityKind == .typing ? 13 : 10)
        case .bored:
            return sleepAnimation
        case .poked:
            return attackAnimation
        case .dragging:
            return walkAnimation.withSpeed(8 + Double(dragSpeed) * 12)
        }
    }
}

struct CharacterAnimation: Decodable, Equatable {
    let folder: String
    let frameCount: Int
    let framesPerSecond: Double
    let loops: Bool

    func withSpeed(_ framesPerSecond: Double) -> CharacterAnimation {
        CharacterAnimation(
            folder: folder,
            frameCount: frameCount,
            framesPerSecond: framesPerSecond,
            loops: loops
        )
    }
}

enum CharacterCatalog {
    static let assets: [CharacterAsset] = loadAssets()

    static func asset(id: String) -> CharacterAsset {
        assets.first { $0.id == id } ?? assets[0]
    }

    private static func loadAssets() -> [CharacterAsset] {
        let loadedAssets = loadBundledAssets() + loadLocalAssets()
        return loadedAssets.isEmpty ? fallbackAssets : loadedAssets
    }

    private static func loadBundledAssets() -> [CharacterAsset] {
        guard let charactersURL = charactersDirectoryURL() else {
            return []
        }

        guard let folders = try? FileManager.default.contentsOfDirectory(
            at: charactersURL,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles]
        ) else {
            return []
        }

        return folders.compactMap { loadAsset(from: $0, isLocal: false) }
            .sorted {
                if $0.sortOrder == $1.sortOrder {
                    return $0.displayName.localizedStandardCompare($1.displayName) == .orderedAscending
                }
                return $0.sortOrder < $1.sortOrder
            }
    }

    private static func loadLocalAssets() -> [CharacterAsset] {
        let charactersURL = localCharactersDirectoryURL()
        try? FileManager.default.createDirectory(at: charactersURL, withIntermediateDirectories: true)

        guard let folders = try? FileManager.default.contentsOfDirectory(
            at: charactersURL,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles]
        ) else {
            return []
        }

        return folders.compactMap { loadAsset(from: $0, isLocal: true) }
            .sorted {
                if $0.sortOrder == $1.sortOrder {
                    return $0.displayName.localizedStandardCompare($1.displayName) == .orderedAscending
                }
                return $0.sortOrder < $1.sortOrder
            }
    }

    private static func charactersDirectoryURL() -> URL? {
        if let url = Bundle.main.url(forResource: "Resources/Characters", withExtension: nil) {
            return url
        }

        return Bundle.main.resourceURL?.appendingPathComponent("Resources/Characters", isDirectory: true)
    }

    private static func localCharactersDirectoryURL() -> URL {
        let applicationSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        return applicationSupportURL
            .appendingPathComponent("Petty", isDirectory: true)
            .appendingPathComponent("Characters", isDirectory: true)
    }

    private static func loadAsset(from folderURL: URL, isLocal: Bool) -> CharacterAsset? {
        guard (try? folderURL.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == true else {
            return nil
        }

        let manifestURL = folderURL.appendingPathComponent("manifest.json")
        guard let data = try? Data(contentsOf: manifestURL),
              let manifest = try? JSONDecoder().decode(CharacterManifest.self, from: data) else {
            return nil
        }

        return CharacterAsset(
            id: manifest.id,
            displayName: manifest.displayName,
            tagline: manifest.tagline,
            resourceFolder: folderURL.lastPathComponent,
            resourceURL: isLocal ? folderURL : nil,
            source: manifest.source,
            sortOrder: manifest.sortOrder,
            idleAnimation: manifest.animations.idle,
            walkAnimation: manifest.animations.walk,
            attackAnimation: manifest.animations.attack,
            sleepAnimation: manifest.animations.sleep
        )
    }

    private static let fallbackAssets: [CharacterAsset] = [
        CharacterAsset(
            id: "gameart2d-zombie",
            displayName: "Zombie",
            tagline: "Halloween platformer character",
            resourceFolder: "GameArt2DZombie",
            resourceURL: nil,
            source: "OpenGameArt CC0 by pzUH / GameArt2D",
            sortOrder: 10,
            idleAnimation: CharacterAnimation(folder: "Idle", frameCount: 15, framesPerSecond: 7, loops: true),
            walkAnimation: CharacterAnimation(folder: "Walk", frameCount: 10, framesPerSecond: 10, loops: true),
            attackAnimation: CharacterAnimation(folder: "Attack", frameCount: 8, framesPerSecond: 14, loops: true),
            sleepAnimation: CharacterAnimation(folder: "Dead", frameCount: 12, framesPerSecond: 4, loops: false)
        ),
        CharacterAsset(
            id: "gameart2d-knight",
            displayName: "Knight",
            tagline: "Fantasy side-scroller hero",
            resourceFolder: "GameArt2DKnight",
            resourceURL: nil,
            source: "GameArt2D Freebie CC0",
            sortOrder: 20,
            idleAnimation: CharacterAnimation(folder: "Idle", frameCount: 10, framesPerSecond: 7, loops: true),
            walkAnimation: CharacterAnimation(folder: "Walk", frameCount: 10, framesPerSecond: 10, loops: true),
            attackAnimation: CharacterAnimation(folder: "Attack", frameCount: 10, framesPerSecond: 14, loops: true),
            sleepAnimation: CharacterAnimation(folder: "Dead", frameCount: 10, framesPerSecond: 4, loops: false)
        ),
        CharacterAsset(
            id: "gameart2d-robot",
            displayName: "Robot",
            tagline: "Sci-fi platformer companion",
            resourceFolder: "GameArt2DRobot",
            resourceURL: nil,
            source: "GameArt2D Freebie CC0",
            sortOrder: 30,
            idleAnimation: CharacterAnimation(folder: "Idle", frameCount: 10, framesPerSecond: 7, loops: true),
            walkAnimation: CharacterAnimation(folder: "Walk", frameCount: 8, framesPerSecond: 10, loops: true),
            attackAnimation: CharacterAnimation(folder: "Attack", frameCount: 8, framesPerSecond: 13, loops: true),
            sleepAnimation: CharacterAnimation(folder: "Dead", frameCount: 10, framesPerSecond: 4, loops: false)
        ),
        CharacterAsset(
            id: "gameart2d-ninja-girl",
            displayName: "Ninja Girl",
            tagline: "Fast action platformer hero",
            resourceFolder: "GameArt2DNinjaGirl",
            resourceURL: nil,
            source: "GameArt2D Freebie CC0",
            sortOrder: 40,
            idleAnimation: CharacterAnimation(folder: "Idle", frameCount: 10, framesPerSecond: 7, loops: true),
            walkAnimation: CharacterAnimation(folder: "Walk", frameCount: 10, framesPerSecond: 12, loops: true),
            attackAnimation: CharacterAnimation(folder: "Attack", frameCount: 10, framesPerSecond: 14, loops: true),
            sleepAnimation: CharacterAnimation(folder: "Dead", frameCount: 10, framesPerSecond: 4, loops: false)
        ),
        CharacterAsset(
            id: "gameart2d-adventurer-girl",
            displayName: "Adventurer",
            tagline: "Temple-run inspired explorer",
            resourceFolder: "GameArt2DAdventurerGirl",
            resourceURL: nil,
            source: "GameArt2D Freebie CC0",
            sortOrder: 50,
            idleAnimation: CharacterAnimation(folder: "Idle", frameCount: 10, framesPerSecond: 7, loops: true),
            walkAnimation: CharacterAnimation(folder: "Walk", frameCount: 8, framesPerSecond: 10, loops: true),
            attackAnimation: CharacterAnimation(folder: "Attack", frameCount: 7, framesPerSecond: 13, loops: true),
            sleepAnimation: CharacterAnimation(folder: "Dead", frameCount: 10, framesPerSecond: 4, loops: false)
        )
    ]
}

private struct CharacterManifest: Decodable {
    let id: String
    let displayName: String
    let tagline: String
    let source: String
    let sortOrder: Int
    let animations: CharacterManifestAnimations
}

private struct CharacterManifestAnimations: Decodable {
    let idle: CharacterAnimation
    let walk: CharacterAnimation
    let attack: CharacterAnimation
    let sleep: CharacterAnimation
}
