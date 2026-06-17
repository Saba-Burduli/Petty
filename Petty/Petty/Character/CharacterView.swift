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
            let expression = expressionMotion(at: time)

            ZStack {
                rigImage("zed_shadow")
                    .frame(width: 110, height: 38)
                    .opacity(shadowOpacity)
                    .scaleEffect(x: shadowScale(at: time), y: 1)
                    .offset(y: 83)

                ZStack {
                    arm(isLeft: true, time: time)
                        .offset(x: -69 + bodyMotion.xOffset * 0.25, y: 36 + bodyMotion.yOffset * 0.6)

                    arm(isLeft: false, time: time)
                        .offset(x: 70 + bodyMotion.xOffset * 0.25, y: 36 + bodyMotion.yOffset * 0.6)

                    rigImage("zed_body")
                        .frame(width: 148, height: 192)
                        .scaleEffect(
                            x: bodyMotion.xScale + dragStretch * 0.18,
                            y: bodyMotion.yScale - dragSquash * 0.18,
                            anchor: .bottom
                        )
                        .rotationEffect(.degrees(bodyMotion.rotation + dragRotation * 0.2), anchor: .bottom)
                        .offset(x: bodyMotion.xOffset, y: bodyMotion.yOffset + 18)

                    neckPatch()
                        .offset(x: headMotion.xOffset * 0.35, y: bodyMotion.yOffset - 2)
                }

                ZStack {
                    rigImage("zed_head")

                    livingFace(expression: expression, blinkAmount: blinkAmount)
                    eyelidPair(amount: blinkAmount)
                }
                .frame(width: 158, height: 153)
                .scaleEffect(
                    x: headMotion.xScale + dragStretch * 0.28,
                    y: headMotion.yScale - dragSquash * 0.28,
                    anchor: .bottom
                )
                .rotationEffect(.degrees(headMotion.rotation + dragRotation * 0.35), anchor: .bottom)
                .offset(
                    x: bodyMotion.xOffset * 0.72 + headMotion.xOffset,
                    y: bodyMotion.yOffset * 0.8 + headMotion.yOffset - 50
                )
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

    private func livingFace(expression: CharacterExpression, blinkAmount: Double) -> some View {
        ZStack {
            eye(isLeft: true, expression: expression, blinkAmount: blinkAmount)
                .offset(x: -38, y: -5)
            eye(isLeft: false, expression: expression, blinkAmount: blinkAmount)
                .offset(x: 42, y: -8)

            mouth(expression: expression)
                .offset(x: 6, y: 36)
        }
    }

    private func eye(isLeft: Bool, expression: CharacterExpression, blinkAmount: Double) -> some View {
        let openness = max(0.08, 1.0 - blinkAmount)
        let pupilX = (isLeft ? -1 : 1) * expression.eyeLook

        return ZStack {
            Capsule()
                .fill(Color(red: 0.88, green: 0.94, blue: 0.77))
                .frame(width: isLeft ? 31 : 29, height: max(3, 19 * openness))
                .shadow(color: .black.opacity(0.18), radius: 1, y: 1)

            Circle()
                .fill(Color(red: 0.10, green: 0.12, blue: 0.11))
                .frame(width: 9, height: max(2, 11 * openness))
                .offset(x: pupilX, y: expression.pupilLift)

            Circle()
                .fill(.white.opacity(openness > 0.45 ? 0.55 : 0))
                .frame(width: 3, height: 3)
                .offset(x: pupilX - 2, y: expression.pupilLift - 2)
        }
    }

    private func mouth(expression: CharacterExpression) -> some View {
        Capsule()
            .fill(Color(red: 0.11, green: 0.08, blue: 0.08).opacity(expression.mouthOpen > 0.1 ? 0.9 : 0.0))
            .overlay(
                Capsule()
                    .stroke(Color(red: 0.13, green: 0.09, blue: 0.08), lineWidth: expression.mouthOpen > 0.1 ? 0 : 3)
                    .opacity(expression.mouthOpen > 0.1 ? 0 : 0.65)
            )
            .frame(width: expression.mouthWidth, height: max(3, expression.mouthOpen))
            .rotationEffect(.degrees(expression.mouthTilt))
    }

    private func arm(isLeft: Bool, time: TimeInterval) -> some View {
        let sign: CGFloat = isLeft ? -1 : 1
        let motion = armMotion(isLeft: isLeft, at: time)

        return ZStack(alignment: isLeft ? .topTrailing : .topLeading) {
            Capsule()
                .fill(Color(red: 0.39, green: 0.49, blue: 0.36))
                .overlay(Capsule().stroke(Color(red: 0.17, green: 0.20, blue: 0.16).opacity(0.45), lineWidth: 1))
                .frame(width: 21, height: 58)
                .rotationEffect(.degrees(Double(sign) * motion.upperRotation), anchor: isLeft ? .topTrailing : .topLeading)

            Capsule()
                .fill(Color(red: 0.45, green: 0.55, blue: 0.39))
                .overlay(Capsule().stroke(Color(red: 0.17, green: 0.20, blue: 0.16).opacity(0.45), lineWidth: 1))
                .frame(width: 18, height: 45)
                .rotationEffect(.degrees(Double(sign) * motion.lowerRotation), anchor: isLeft ? .topTrailing : .topLeading)
                .offset(x: sign * 10, y: 42 + motion.reach)

            Circle()
                .fill(Color(red: 0.46, green: 0.57, blue: 0.40))
                .frame(width: 23, height: 20)
                .offset(x: sign * 18, y: 80 + motion.reach)
        }
        .rotationEffect(.degrees(Double(sign) * motion.wholeRotation), anchor: .top)
        .offset(y: motion.reach)
        .opacity(stateManager.state == .bored ? 0.72 : 0.94)
    }

    private func neckPatch() -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color(red: 0.39, green: 0.48, blue: 0.34))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black.opacity(0.18), lineWidth: 1))
            .frame(width: 42, height: 48)
    }

    private func bodyMotion(at time: TimeInterval) -> CharacterMotion {
        switch stateManager.state {
        case .idle:
            let breath = sin(time * 2.0)
            return CharacterMotion(
                xScale: 1.0 + breath * 0.01,
                yScale: 1.0 - breath * 0.008,
                yOffset: breath * -1.8,
                rotation: sin(time * 0.7) * 0.45
            )
        case .active:
            let typingBoost = stateManager.activityKind == .typing ? 1.35 : 1.0
            let bounce = abs(sin(time * 7.4 * typingBoost))
            return CharacterMotion(
                xScale: 1.0 + bounce * 0.018,
                yScale: 0.99 - bounce * 0.014,
                xOffset: sin(time * 9) * 1.4,
                yOffset: -4 - bounce * 7,
                rotation: sin(time * 8) * 1.7
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
                xOffset: CGFloat(wobble * speed * 2),
                yOffset: -2,
                rotation: wobble * speed * 2.4
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
                xOffset: drift * 0.9,
                yOffset: nod * -1.2,
                rotation: drift * 1.3
            )
        case .active:
            let typingBoost = stateManager.activityKind == .typing ? 1.45 : 1.0
            let bob = abs(sin(time * 7.4 * typingBoost))
            return CharacterMotion(
                xScale: 1.01 + bob * 0.02,
                yScale: 0.99 - bob * 0.01,
                xOffset: sin(time * 10.5) * 1.8,
                yOffset: -6 - bob * 9,
                rotation: sin(time * 10.5) * 2.8
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
                xOffset: CGFloat(wobble * speed * 2.6),
                yOffset: -4,
                rotation: wobble * speed * 4.5
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

    private func expressionMotion(at time: TimeInterval) -> CharacterExpression {
        switch stateManager.state {
        case .idle:
            return CharacterExpression(
                eyeLook: sin(time * 0.65) * 2.5,
                pupilLift: sin(time * 1.2) * 0.8,
                mouthOpen: 0,
                mouthWidth: 28,
                mouthTilt: sin(time * 0.8) * 2
            )
        case .active:
            let typing = stateManager.activityKind == .typing
            let chatter = typing ? abs(sin(time * 18)) : abs(sin(time * 8))
            return CharacterExpression(
                eyeLook: sin(time * (typing ? 6.5 : 3.0)) * 3.5,
                pupilLift: -1.0,
                mouthOpen: 5 + chatter * (typing ? 10 : 5),
                mouthWidth: typing ? 24 : 30,
                mouthTilt: sin(time * 5) * 4
            )
        case .bored:
            return CharacterExpression(
                eyeLook: -2,
                pupilLift: 1.5,
                mouthOpen: 3 + abs(sin(time * 0.7)) * 6,
                mouthWidth: 18,
                mouthTilt: -8
            )
        case .dragging:
            let speed = Double(stateManager.dragSpeed)
            return CharacterExpression(
                eyeLook: 5 * speed,
                pupilLift: -2,
                mouthOpen: 7 + speed * 10,
                mouthWidth: 25 + speed * 8,
                mouthTilt: 3
            )
        case .poked:
            return CharacterExpression(
                eyeLook: sin(time * 25) * 5,
                pupilLift: -2,
                mouthOpen: 16,
                mouthWidth: 24,
                mouthTilt: sin(time * 18) * 8
            )
        }
    }

    private func armMotion(isLeft: Bool, at time: TimeInterval) -> ArmMotion {
        let phase = isLeft ? 0.0 : .pi
        switch stateManager.state {
        case .idle:
            return ArmMotion(
                upperRotation: 9 + sin(time * 1.8 + phase) * 2,
                lowerRotation: 18 + sin(time * 1.4 + phase) * 4,
                wholeRotation: sin(time * 0.9 + phase) * 1.5,
                reach: sin(time * 2.0 + phase) * -1
            )
        case .active:
            let typing = stateManager.activityKind == .typing
            let beat = abs(sin(time * (typing ? 13 : 7) + phase))
            return ArmMotion(
                upperRotation: typing ? -10 + beat * 24 : 16 + beat * 12,
                lowerRotation: typing ? -8 + beat * 30 : 20 + beat * 12,
                wholeRotation: typing ? -8 + beat * 16 : beat * 6,
                reach: typing ? -12 + beat * 8 : -5 - beat * 8
            )
        case .bored:
            return ArmMotion(upperRotation: 2, lowerRotation: 10, wholeRotation: -6, reach: 12)
        case .dragging:
            let speed = Double(stateManager.dragSpeed)
            let shake = sin(time * (10 + speed * 20) + phase)
            return ArmMotion(
                upperRotation: 20 + shake * speed * 18,
                lowerRotation: 25 + shake * speed * 22,
                wholeRotation: shake * speed * 14,
                reach: -8 - speed * 16
            )
        case .poked:
            let recoil = abs(sin(time * 16 + phase))
            return ArmMotion(
                upperRotation: -12 - recoil * 20,
                lowerRotation: -18 - recoil * 22,
                wholeRotation: -10 - recoil * 12,
                reach: -20 - recoil * 8
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

    private func shadowScale(at time: TimeInterval) -> CGFloat {
        switch stateManager.state {
        case .active:
            1.05 + abs(sin(time * 7.4)) * 0.1
        case .dragging:
            1.02 + stateManager.dragSpeed * 0.18
        case .bored:
            1.15
        default:
            1.0 + sin(time * 2.0) * 0.02
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
        stateManager.state == .dragging ? Double(stateManager.dragSpeed * 6) : 0
    }
}

private struct CharacterMotion {
    var xScale: CGFloat = 1
    var yScale: CGFloat = 1
    var xOffset: CGFloat = 0
    var yOffset: CGFloat = 0
    var rotation: Double = 0
}

private struct CharacterExpression {
    var eyeLook: Double
    var pupilLift: Double
    var mouthOpen: Double
    var mouthWidth: Double
    var mouthTilt: Double
}

private struct ArmMotion {
    var upperRotation: Double
    var lowerRotation: Double
    var wholeRotation: Double
    var reach: Double
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
