import Foundation

struct CharacterAsset: Identifiable, Equatable {
    let id: String
    let displayName: String
    let tagline: String
    let resourceFolder: String
    let source: String

    func frameName(for state: CharacterState, dragSpeed: CGFloat) -> String {
        switch state {
        case .idle:
            return "zed_idle"
        case .active:
            return "zed_active"
        case .bored:
            return "zed_bored"
        case .poked:
            return "zed_poked"
        case .dragging:
            return dragSpeed > 0.45 ? "zed_drag_fast" : "zed_drag_slow"
        }
    }
}

enum CharacterCatalog {
    static let assets: [CharacterAsset] = [
        CharacterAsset(
            id: "zed",
            displayName: "Zed",
            tagline: "Sleepy indie zombie companion",
            resourceFolder: "Zed",
            source: "AI-generated original asset"
        )
    ]

    static func asset(id: String) -> CharacterAsset {
        assets.first { $0.id == id } ?? assets[0]
    }
}
