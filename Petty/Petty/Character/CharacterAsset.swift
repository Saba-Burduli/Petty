import SwiftUI

enum CharacterShape: String, CaseIterable {
    case round
    case capsule
    case star
}

struct CharacterAsset: Identifiable, Equatable {
    let id: String
    let displayName: String
    let tagline: String
    let shape: CharacterShape
    let primaryColor: Color
    let secondaryColor: Color
    let accentColor: Color
    let source: String
}

enum CharacterCatalog {
    static let assets: [CharacterAsset] = [
        CharacterAsset(
            id: "petty",
            displayName: "Petty",
            tagline: "Original desktop companion",
            shape: .round,
            primaryColor: Color(red: 0.18, green: 0.74, blue: 0.55),
            secondaryColor: Color(red: 0.07, green: 0.38, blue: 0.34),
            accentColor: Color(red: 0.96, green: 0.31, blue: 0.25),
            source: "Built in"
        ),
        CharacterAsset(
            id: "mochi",
            displayName: "Mochi",
            tagline: "Soft idle-focused buddy",
            shape: .capsule,
            primaryColor: Color(red: 0.98, green: 0.74, blue: 0.45),
            secondaryColor: Color(red: 0.93, green: 0.42, blue: 0.42),
            accentColor: Color(red: 0.20, green: 0.47, blue: 0.85),
            source: "Built in"
        ),
        CharacterAsset(
            id: "orbit",
            displayName: "Orbit",
            tagline: "High-energy focus sprite",
            shape: .star,
            primaryColor: Color(red: 0.30, green: 0.50, blue: 0.96),
            secondaryColor: Color(red: 0.15, green: 0.18, blue: 0.42),
            accentColor: Color(red: 0.98, green: 0.80, blue: 0.26),
            source: "Built in"
        )
    ]

    static func asset(id: String) -> CharacterAsset {
        assets.first { $0.id == id } ?? assets[0]
    }
}
