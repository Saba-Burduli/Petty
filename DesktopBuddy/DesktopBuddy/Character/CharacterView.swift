import SwiftUI

struct CharacterView: View {
    @ObservedObject var stateManager: CharacterStateManager

    private var state: CharacterState {
        stateManager.state
    }

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                bodyShape
                face
                headband
            }
            .frame(width: 116, height: 116)
            .scaleEffect(scale)
            .offset(y: yOffset)
            .animation(.easeInOut(duration: animationDuration).repeatForever(autoreverses: true), value: state)

            Text(label)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.black.opacity(0.48), in: Capsule())
        }
        .padding(8)
        .frame(width: 150, height: 160)
        .contentShape(Rectangle())
    }

    private var bodyShape: some View {
        RoundedRectangle(cornerRadius: 34, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [Color(red: 0.18, green: 0.74, blue: 0.55), Color(red: 0.07, green: 0.38, blue: 0.34)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 34, style: .continuous)
                    .stroke(.white.opacity(0.55), lineWidth: 3)
            )
            .shadow(color: .black.opacity(0.22), radius: 12, x: 0, y: 8)
    }

    private var headband: some View {
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(red: 0.96, green: 0.31, blue: 0.25))
                .frame(width: 76, height: 12)
                .offset(y: 18)
            Spacer()
        }
    }

    private var face: some View {
        VStack(spacing: 10) {
            HStack(spacing: 24) {
                eye
                eye
            }

            mouth
                .stroke(.white, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .frame(width: 34, height: 18)
        }
        .offset(y: 12)
    }

    private var eye: some View {
        Capsule()
            .fill(.white)
            .frame(width: state == .bored ? 18 : 14, height: state == .bored ? 4 : 18)
    }

    private var mouth: Path {
        Path { path in
            switch state {
            case .active:
                path.move(to: CGPoint(x: 4, y: 5))
                path.addQuadCurve(to: CGPoint(x: 30, y: 5), control: CGPoint(x: 17, y: 22))
            case .bored:
                path.move(to: CGPoint(x: 5, y: 14))
                path.addQuadCurve(to: CGPoint(x: 29, y: 14), control: CGPoint(x: 17, y: 2))
            case .dragging:
                path.addEllipse(in: CGRect(x: 10, y: 3, width: 14, height: 14))
            case .idle:
                path.move(to: CGPoint(x: 6, y: 8))
                path.addQuadCurve(to: CGPoint(x: 28, y: 8), control: CGPoint(x: 17, y: 16))
            }
        }
    }

    private var label: String {
        switch state {
        case .idle: "Repz"
        case .active: "Repz reps"
        case .bored: "Repz bored"
        case .dragging: "Whoa"
        }
    }

    private var scale: CGFloat {
        switch state {
        case .active: 1.06
        case .dragging: 1.02
        case .bored: 0.96
        case .idle: 1.0
        }
    }

    private var yOffset: CGFloat {
        switch state {
        case .active: -6
        case .bored: 6
        case .dragging: -2
        case .idle: 0
        }
    }

    private var animationDuration: Double {
        state == .active ? 0.35 : 1.6
    }
}
