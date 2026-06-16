import AppKit
import RiveRuntime
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
        RiveCharacterView(stateManager: stateManager, settingsStore: settingsStore)
    }
}

private struct RiveCharacterView: View {
    @ObservedObject var stateManager: CharacterStateManager
    @ObservedObject var settingsStore: SettingsStore
    @StateObject private var riveViewModel = RiveViewModel(fileName: "Resources/halloween", fit: .contain)

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { timeline in
            let motion = motion(at: timeline.date.timeIntervalSinceReferenceDate)

            riveViewModel.view()
                .frame(width: 210, height: 210)
                .scaleEffect(
                    x: motion.xScale + dragStretch,
                    y: motion.yScale - dragSquash,
                    anchor: .bottom
                )
                .rotationEffect(.degrees(motion.rotation + dragRotation), anchor: .bottom)
                .offset(x: motion.xOffset, y: motion.yOffset)
                .animation(.easeInOut(duration: 0.22), value: stateManager.state)
                .animation(.interactiveSpring(response: 0.16, dampingFraction: 0.55), value: stateManager.dragSpeed)
        }
        .padding(6)
        .frame(width: 220, height: 220)
        .scaleEffect(settingsStore.characterScale)
        .contentShape(Rectangle())
    }

    private func motion(at time: TimeInterval) -> CharacterMotion {
        switch stateManager.state {
        case .idle:
            let breath = sin(time * 2.0)
            return CharacterMotion(
                xScale: 1.0 + breath * 0.012,
                yScale: 1.0 - breath * 0.01,
                yOffset: breath * -2,
                rotation: sin(time * 0.8) * 1.1
            )
        case .active:
            let bounce = abs(sin(time * 7.0))
            return CharacterMotion(
                xScale: 1.01 + bounce * 0.026,
                yScale: 0.99 - bounce * 0.018,
                xOffset: sin(time * 10) * 4,
                yOffset: -5 - bounce * 8,
                rotation: sin(time * 9) * 4
            )
        case .bored:
            let sleepy = sin(time * 1.05)
            return CharacterMotion(
                xScale: 0.99 + sleepy * 0.005,
                yScale: 0.95 - sleepy * 0.005,
                yOffset: 12 + sleepy * 2,
                rotation: -4 + sleepy * 1
            )
        case .dragging:
            let speed = Double(stateManager.dragSpeed)
            let wobble = sin(time * (8 + speed * 16))
            return CharacterMotion(
                xScale: 1.0 + speed * 0.04,
                yScale: 1.0 - speed * 0.03,
                xOffset: CGFloat(wobble * speed * 5),
                yOffset: -3,
                rotation: wobble * speed * 7
            )
        case .poked:
            let flinch = abs(sin(time * 14))
            return CharacterMotion(
                xScale: 1.06 + flinch * 0.035,
                yScale: 0.95 - flinch * 0.02,
                yOffset: -8 - flinch * 7,
                rotation: sin(time * 18) * 5
            )
        }
    }

    private var dragStretch: CGFloat {
        stateManager.state == .dragging ? stateManager.dragSpeed * 0.2 : 0
    }

    private var dragSquash: CGFloat {
        stateManager.state == .dragging ? stateManager.dragSpeed * 0.14 : 0
    }

    private var dragRotation: Double {
        stateManager.state == .dragging ? Double(stateManager.dragSpeed * 18) : 0
    }
}

private struct PNGCharacterView: View {
    @ObservedObject var stateManager: CharacterStateManager
    @ObservedObject var settingsStore: SettingsStore

    private var state: CharacterState {
        stateManager.state
    }

    private var asset: CharacterAsset {
        CharacterCatalog.asset(id: settingsStore.selectedCharacterID)
    }

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { timeline in
            let motion = motion(at: timeline.date.timeIntervalSinceReferenceDate)

            characterImage
                .frame(width: 190, height: 190)
                .scaleEffect(
                    x: motion.xScale + dragStretch,
                    y: motion.yScale - dragSquash,
                    anchor: .bottom
                )
                .rotationEffect(.degrees(motion.rotation + dragRotation), anchor: .bottom)
                .offset(x: motion.xOffset, y: motion.yOffset)
                .animation(.easeInOut(duration: 0.22), value: state)
                .animation(.interactiveSpring(response: 0.16, dampingFraction: 0.55), value: stateManager.dragSpeed)
        }
        .padding(10)
        .frame(width: 220, height: 220)
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

    private func motion(at time: TimeInterval) -> CharacterMotion {
        switch state {
        case .idle:
            let breath = sin(time * 2.2)
            return CharacterMotion(
                xScale: 1.0 + breath * 0.018,
                yScale: 1.0 - breath * 0.012,
                yOffset: breath * -2,
                rotation: sin(time * 0.9) * 1.4
            )
        case .active:
            let bounce = abs(sin(time * 7.5))
            return CharacterMotion(
                xScale: 1.02 + bounce * 0.035,
                yScale: 0.98 - bounce * 0.02,
                xOffset: sin(time * 11) * 4,
                yOffset: -6 - bounce * 10,
                rotation: sin(time * 10) * 5
            )
        case .bored:
            let sleepy = sin(time * 1.15)
            return CharacterMotion(
                xScale: 0.98 + sleepy * 0.006,
                yScale: 0.94 - sleepy * 0.006,
                yOffset: 13 + sleepy * 2,
                rotation: -5 + sleepy * 1.2
            )
        case .dragging:
            let speed = Double(stateManager.dragSpeed)
            let wobble = sin(time * (8 + speed * 16))
            return CharacterMotion(
                xScale: 1.0 + speed * 0.04,
                yScale: 1.0 - speed * 0.03,
                xOffset: CGFloat(wobble * speed * 5),
                yOffset: -3,
                rotation: wobble * speed * 7
            )
        case .poked:
            let flinch = abs(sin(time * 14))
            return CharacterMotion(
                xScale: 1.08 + flinch * 0.04,
                yScale: 0.93 - flinch * 0.02,
                yOffset: -8 - flinch * 8,
                rotation: sin(time * 18) * 5
            )
        }
    }

    private var dragStretch: CGFloat {
        state == .dragging ? stateManager.dragSpeed * 0.2 : 0
    }

    private var dragSquash: CGFloat {
        state == .dragging ? stateManager.dragSpeed * 0.14 : 0
    }

    private var dragRotation: Double {
        state == .dragging ? Double(stateManager.dragSpeed * 18) : 0
    }
}

private struct CharacterMotion {
    var xScale: CGFloat = 1
    var yScale: CGFloat = 1
    var xOffset: CGFloat = 0
    var yOffset: CGFloat = 0
    var rotation: Double = 0
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
