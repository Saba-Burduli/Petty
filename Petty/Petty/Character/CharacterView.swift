import AppKit
import SwiftUI

struct CharacterView: View {
    @ObservedObject var stateManager: CharacterStateManager
    @ObservedObject var settingsStore: SettingsStore

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate
            let bodyMotion = bodyMotion(at: time)
            let headMotion = headMotion(at: time)
            let blinkAmount = blinkAmount(at: time)

            ZStack {
                rigImage("zed_shadow")
                    .frame(width: 110, height: 38)
                    .opacity(shadowOpacity)
                    .offset(y: 82)

                rigImage("zed_body")
                    .frame(width: 148, height: 192)
                    .scaleEffect(
                        x: bodyMotion.xScale + dragStretch * 0.35,
                        y: bodyMotion.yScale - dragSquash * 0.35,
                        anchor: .bottom
                    )
                    .rotationEffect(.degrees(bodyMotion.rotation + dragRotation * 0.35), anchor: .bottom)
                    .offset(x: bodyMotion.xOffset, y: bodyMotion.yOffset + 18)

                ZStack {
                    rigImage("zed_head")

                    eyelidPair(amount: blinkAmount)
                }
                .frame(width: 158, height: 153)
                .scaleEffect(
                    x: headMotion.xScale + dragStretch,
                    y: headMotion.yScale - dragSquash,
                    anchor: .bottom
                )
                .rotationEffect(.degrees(headMotion.rotation + dragRotation), anchor: .bottom)
                .offset(x: headMotion.xOffset, y: headMotion.yOffset - 50)
            }
            .frame(width: 220, height: 220)
            .scaleEffect(settingsStore.characterScale)
            .animation(.easeInOut(duration: 0.22), value: stateManager.state)
            .animation(.interactiveSpring(response: 0.16, dampingFraction: 0.55), value: stateManager.dragSpeed)
        }
        .padding(6)
        .frame(width: 220, height: 220)
        .contentShape(Rectangle())
    }

    private func rigImage(_ name: String) -> some View {
        Group {
            if let image = CharacterImageLoader.rigImage(named: name, characterFolder: "Zed") {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Color.clear
            }
        }
    }

    private func eyelidPair(amount: Double) -> some View {
        let height = max(3, 34 * amount)
        let yOffset = 5 + (1 - amount) * -8

        return ZStack {
            eyelid(width: 47, height: height)
                .rotationEffect(.degrees(-9))
                .offset(x: -38, y: yOffset)

            eyelid(width: 43, height: height * 0.92)
                .rotationEffect(.degrees(7))
                .offset(x: 42, y: yOffset - 4)
        }
        .opacity(amount <= 0.02 ? 0 : 1)
    }

    private func eyelid(width: CGFloat, height: CGFloat) -> some View {
        Capsule()
            .fill(Color(red: 0.50, green: 0.56, blue: 0.45))
            .overlay(Capsule().stroke(Color(red: 0.22, green: 0.25, blue: 0.21).opacity(0.45), lineWidth: 1))
            .frame(width: width, height: height)
    }

    private func bodyMotion(at time: TimeInterval) -> CharacterMotion {
        switch stateManager.state {
        case .idle:
            let breath = sin(time * 2.0)
            return CharacterMotion(
                xScale: 1.0 + breath * 0.01,
                yScale: 1.0 - breath * 0.008,
                yOffset: breath * -1.4,
                rotation: sin(time * 0.7) * 0.6
            )
        case .active:
            let bounce = abs(sin(time * 7.4))
            return CharacterMotion(
                xScale: 1.0 + bounce * 0.018,
                yScale: 0.99 - bounce * 0.014,
                xOffset: sin(time * 9) * 2.5,
                yOffset: -4 - bounce * 7,
                rotation: sin(time * 8) * 2.4
            )
        case .bored:
            let sleepy = sin(time * 1.0)
            return CharacterMotion(
                xScale: 0.99 + sleepy * 0.004,
                yScale: 0.95 - sleepy * 0.004,
                yOffset: 11 + sleepy * 1.3,
                rotation: -2.2 + sleepy * 0.5
            )
        case .dragging:
            let speed = Double(stateManager.dragSpeed)
            let wobble = sin(time * (7 + speed * 15))
            return CharacterMotion(
                xScale: 1.0 + speed * 0.025,
                yScale: 1.0 - speed * 0.018,
                xOffset: CGFloat(wobble * speed * 3),
                yOffset: -2,
                rotation: wobble * speed * 4
            )
        case .poked:
            let flinch = abs(sin(time * 14))
            return CharacterMotion(
                xScale: 1.02 + flinch * 0.015,
                yScale: 0.98 - flinch * 0.014,
                yOffset: -3 - flinch * 4,
                rotation: sin(time * 16) * 1.8
            )
        }
    }

    private func headMotion(at time: TimeInterval) -> CharacterMotion {
        switch stateManager.state {
        case .idle:
            let drift = sin(time * 0.85)
            let nod = sin(time * 1.8)
            return CharacterMotion(
                xScale: 1,
                yScale: 1,
                xOffset: drift * 2.4,
                yOffset: nod * -2,
                rotation: drift * 3.0
            )
        case .active:
            let bob = abs(sin(time * 7.4))
            return CharacterMotion(
                xScale: 1.01 + bob * 0.02,
                yScale: 0.99 - bob * 0.01,
                xOffset: sin(time * 10.5) * 4,
                yOffset: -6 - bob * 9,
                rotation: sin(time * 10.5) * 7
            )
        case .bored:
            let sleep = sin(time * 0.85)
            return CharacterMotion(
                xScale: 0.99,
                yScale: 0.98,
                xOffset: -5 + sleep * 1.2,
                yOffset: 13 + sleep * 1.2,
                rotation: -11 + sleep * 1.8
            )
        case .dragging:
            let speed = Double(stateManager.dragSpeed)
            let wobble = sin(time * (10 + speed * 20))
            return CharacterMotion(
                xScale: 1.0 + speed * 0.04,
                yScale: 1.0 - speed * 0.02,
                xOffset: CGFloat(wobble * speed * 7),
                yOffset: -4,
                rotation: wobble * speed * 11
            )
        case .poked:
            let flinch = abs(sin(time * 15))
            return CharacterMotion(
                xScale: 1.06 + flinch * 0.035,
                yScale: 0.95 - flinch * 0.02,
                xOffset: sin(time * 22) * 3,
                yOffset: -10 - flinch * 9,
                rotation: sin(time * 20) * 8
            )
        }
    }

    private func blinkAmount(at time: TimeInterval) -> Double {
        switch stateManager.state {
        case .bored:
            return 0.82 + abs(sin(time * 0.75)) * 0.16
        case .dragging:
            return stateManager.dragSpeed > 0.55 ? 0.58 : 0.12
        case .poked:
            return 0.72
        default:
            let cycle = time.truncatingRemainder(dividingBy: 4.8)
            guard cycle > 4.52 else { return 0 }
            let progress = min((cycle - 4.52) / 0.28, 1)
            return sin(progress * .pi)
        }
    }

    private var shadowOpacity: Double {
        switch stateManager.state {
        case .active: 0.22
        case .bored: 0.34
        default: 0.28
        }
    }

    private var dragStretch: CGFloat {
        stateManager.state == .dragging ? stateManager.dragSpeed * 0.16 : 0
    }

    private var dragSquash: CGFloat {
        stateManager.state == .dragging ? stateManager.dragSpeed * 0.1 : 0
    }

    private var dragRotation: Double {
        stateManager.state == .dragging ? Double(stateManager.dragSpeed * 12) : 0
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
    static func rigImage(named name: String, characterFolder: String) -> NSImage? {
        let relativePath = "Resources/Characters/\(characterFolder)/Rig/\(name)"
        guard let url = Bundle.main.url(forResource: relativePath, withExtension: "png") else {
            return nil
        }
        return NSImage(contentsOf: url)
    }

    static func frameImage(named name: String, characterFolder: String) -> NSImage? {
        let relativePath = "Resources/Characters/\(characterFolder)/Frames/\(name)"
        guard let url = Bundle.main.url(forResource: relativePath, withExtension: "png") else {
            return nil
        }
        return NSImage(contentsOf: url)
    }
}
