import AppKit
import SwiftUI

struct CharacterView: View {
    @ObservedObject var stateManager: CharacterStateManager
    @ObservedObject var settingsStore: SettingsStore

    private var selectedAsset: CharacterAsset {
        CharacterCatalog.asset(id: settingsStore.selectedCharacterID)
    }

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 24.0)) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate
            let animation = selectedAsset.animation(
                for: stateManager.state,
                activityKind: stateManager.activityKind,
                dragSpeed: stateManager.dragSpeed
            )
            let frameNumber = frameNumber(for: animation, at: time)

            ZStack {
                Ellipse()
                    .fill(.black.opacity(shadowOpacity))
                    .frame(width: 96, height: 22)
                    .blur(radius: 2)
                    .offset(y: 82)

                if let image = CharacterImageLoader.animationFrame(
                    asset: selectedAsset,
                    animation: animation,
                    frameNumber: frameNumber
                ) {
                    Image(nsImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 190, height: 205)
                        .scaleEffect(spriteScale(for: animation), anchor: .bottom)
                        .rotationEffect(.degrees(spriteRotation(for: animation)), anchor: .bottom)
                        .offset(y: spriteYOffset(for: animation))
                } else {
                    Text("Missing asset")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: 220, height: 220)
            .scaleEffect(settingsStore.characterScale)
            .animation(.easeInOut(duration: 0.16), value: stateManager.state)
            .animation(.interactiveSpring(response: 0.18, dampingFraction: 0.7), value: stateManager.dragSpeed)
        }
        .padding(6)
        .frame(width: 220, height: 220)
        .contentShape(Rectangle())
    }

    private func frameNumber(for animation: CharacterAnimation, at time: TimeInterval) -> Int {
        let rawIndex = Int((time * animation.framesPerSecond).rounded(.down))
        if animation.loops {
            return rawIndex % animation.frameCount + 1
        }
        return min(rawIndex, animation.frameCount - 1) + 1
    }

    private func spriteScale(for animation: CharacterAnimation) -> CGFloat {
        guard stateManager.state == .dragging else { return 1 }
        return 1 + stateManager.dragSpeed * 0.08
    }

    private func spriteRotation(for animation: CharacterAnimation) -> Double {
        guard stateManager.state == .dragging else { return 0 }
        return Double(stateManager.dragSpeed * 5)
    }

    private func spriteYOffset(for animation: CharacterAnimation) -> CGFloat {
        switch stateManager.state {
        case .active:
            return -4
        case .bored:
            return 10
        case .dragging:
            return -8
        case .poked:
            return -6
        case .idle:
            return 0
        }
    }

    private var shadowOpacity: Double {
        switch stateManager.state {
        case .active, .dragging:
            0.22
        case .bored:
            0.34
        case .idle, .poked:
            0.28
        }
    }
}

enum CharacterImageLoader {
    static func animationFrame(asset: CharacterAsset, animation: CharacterAnimation, frameNumber: Int) -> NSImage? {
        let fileName = "\(animation.folder)_\(String(format: "%03d", frameNumber))"
        if let resourceURL = asset.resourceURL {
            let url = resourceURL
                .appendingPathComponent("Frames", isDirectory: true)
                .appendingPathComponent(animation.folder, isDirectory: true)
                .appendingPathComponent("\(fileName).png")
            return NSImage(contentsOf: url)
        }

        let relativePath = "Resources/Characters/\(asset.resourceFolder)/Frames/\(animation.folder)/\(fileName)"
        guard let url = Bundle.main.url(forResource: relativePath, withExtension: "png") else {
            return nil
        }
        return NSImage(contentsOf: url)
    }

    static func previewImage(asset: CharacterAsset) -> NSImage? {
        animationFrame(asset: asset, animation: asset.previewAnimation, frameNumber: 1)
    }
}
