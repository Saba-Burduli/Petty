import AppKit
import SwiftUI

struct CharacterView: View {
    @ObservedObject var stateManager: CharacterStateManager
    @ObservedObject var settingsStore: SettingsStore

    private var state: CharacterState {
        stateManager.state
    }

    private var asset: CharacterAsset {
        CharacterCatalog.asset(id: settingsStore.selectedCharacterID)
    }

    var body: some View {
        VStack(spacing: 4) {
            characterImage
                .frame(width: 150, height: 142)
                .scaleEffect(x: scale + dragStretch, y: scale - dragSquash)
                .rotationEffect(.degrees(dragRotation))
                .offset(y: yOffset)
                .animation(.easeInOut(duration: animationDuration).repeatForever(autoreverses: true), value: state)
                .animation(.interactiveSpring(response: 0.18, dampingFraction: 0.58), value: stateManager.dragSpeed)

            Text(label)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.black.opacity(0.48), in: Capsule())
        }
        .padding(8)
        .frame(width: 170, height: 180)
        .scaleEffect(settingsStore.characterScale)
        .contentShape(Rectangle())
    }

    private var characterImage: some View {
        Group {
            if let image = CharacterImageLoader.image(
                named: asset.frameName(for: state, dragSpeed: stateManager.dragSpeed),
                characterFolder: asset.resourceFolder
            ) {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black.opacity(0.24), radius: 10, x: 0, y: 8)
            } else {
                Text("Missing asset")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(.red, in: RoundedRectangle(cornerRadius: 8))
            }
        }
    }

    private var label: String {
        switch state {
        case .idle: asset.displayName
        case .active: "\(asset.displayName) shuffles"
        case .bored: "\(asset.displayName) sleepy"
        case .dragging: "Dragged"
        case .poked: "Poked"
        }
    }

    private var scale: CGFloat {
        switch state {
        case .active: 1.04
        case .dragging: 1.02
        case .poked: 1.08
        case .bored: 0.96
        case .idle: 1.0
        }
    }

    private var yOffset: CGFloat {
        switch state {
        case .active: -8
        case .bored: 7
        case .dragging: -2
        case .poked: -11
        case .idle: 0
        }
    }

    private var animationDuration: Double {
        switch state {
        case .active, .poked: 0.35
        default: 1.6
        }
    }

    private var dragStretch: CGFloat {
        state == .dragging ? stateManager.dragSpeed * 0.2 : 0
    }

    private var dragSquash: CGFloat {
        state == .dragging ? stateManager.dragSpeed * 0.14 : 0
    }

    private var dragRotation: Double {
        state == .dragging ? Double(stateManager.dragSpeed * 20) : 0
    }
}

enum CharacterImageLoader {
    static func image(named name: String, characterFolder: String) -> NSImage? {
        let relativePath = "Resources/Characters/\(characterFolder)/Frames/\(name)"
        guard let url = Bundle.main.url(forResource: relativePath, withExtension: "png") else {
            return nil
        }
        return NSImage(contentsOf: url)
    }
}
