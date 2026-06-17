import Foundation

struct CharacterAsset: Identifiable, Equatable {
    let id: String
    let displayName: String
    let tagline: String
    let resourceFolder: String
    let source: String
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

struct CharacterAnimation: Equatable {
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
    static let assets: [CharacterAsset] = [
        CharacterAsset(
            id: "gameart2d-zombie",
            displayName: "Zombie",
            tagline: "Halloween platformer character",
            resourceFolder: "GameArt2DZombie",
            source: "OpenGameArt CC0 by pzUH / GameArt2D",
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
            source: "GameArt2D Freebie CC0",
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
            source: "GameArt2D Freebie CC0",
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
            source: "GameArt2D Freebie CC0",
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
            source: "GameArt2D Freebie CC0",
            idleAnimation: CharacterAnimation(folder: "Idle", frameCount: 10, framesPerSecond: 7, loops: true),
            walkAnimation: CharacterAnimation(folder: "Walk", frameCount: 8, framesPerSecond: 10, loops: true),
            attackAnimation: CharacterAnimation(folder: "Attack", frameCount: 7, framesPerSecond: 13, loops: true),
            sleepAnimation: CharacterAnimation(folder: "Dead", frameCount: 10, framesPerSecond: 4, loops: false)
        )
    ]

    static func asset(id: String) -> CharacterAsset {
        assets.first { $0.id == id } ?? assets[0]
    }
}
