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
        VStack(spacing: 6) {
            ZStack {
                bodyShape
                face
                headband
            }
            .frame(width: 116, height: 116)
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
        .frame(width: 150, height: 160)
        .scaleEffect(settingsStore.characterScale)
        .contentShape(Rectangle())
    }

    private var bodyShape: some View {
        ZStack {
            switch asset.shape {
            case .round:
                RoundedRectangle(cornerRadius: 34, style: .continuous)
                    .fill(fillGradient)
                    .overlay(RoundedRectangle(cornerRadius: 34, style: .continuous).stroke(.white.opacity(0.55), lineWidth: 3))
            case .capsule:
                Capsule()
                    .fill(fillGradient)
                    .overlay(Capsule().stroke(.white.opacity(0.55), lineWidth: 3))
            case .star:
                StarShape()
                    .fill(fillGradient)
                    .overlay(StarShape().stroke(.white.opacity(0.55), lineWidth: 3))
            }
        }
        .shadow(color: .black.opacity(0.22), radius: 12, x: 0, y: 8)
    }

    private var fillGradient: LinearGradient {
        LinearGradient(
            colors: [asset.primaryColor, asset.secondaryColor],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var headband: some View {
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(asset.accentColor)
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
            case .poked:
                path.move(to: CGPoint(x: 5, y: 8))
                path.addLine(to: CGPoint(x: 29, y: 8))
            case .idle:
                path.move(to: CGPoint(x: 6, y: 8))
                path.addQuadCurve(to: CGPoint(x: 28, y: 8), control: CGPoint(x: 17, y: 16))
            }
        }
    }

    private var label: String {
        switch state {
        case .idle: asset.displayName
        case .active: "\(asset.displayName) moves"
        case .bored: "\(asset.displayName) bored"
        case .dragging: "Whoa"
        case .poked: "Boop"
        }
    }

    private var scale: CGFloat {
        switch state {
        case .active: 1.06
        case .dragging: 1.02
        case .poked: 1.12
        case .bored: 0.96
        case .idle: 1.0
        }
    }

    private var yOffset: CGFloat {
        switch state {
        case .active: -6
        case .bored: 6
        case .dragging: -2
        case .poked: -10
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
        state == .dragging ? stateManager.dragSpeed * 0.22 : 0
    }

    private var dragSquash: CGFloat {
        state == .dragging ? stateManager.dragSpeed * 0.12 : 0
    }

    private var dragRotation: Double {
        state == .dragging ? Double(stateManager.dragSpeed * 18) : 0
    }
}

struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.58
        var path = Path()

        for index in 0..<10 {
            let radius = index.isMultiple(of: 2) ? outerRadius : innerRadius
            let angle = CGFloat(index) * .pi / 5 - .pi / 2
            let point = CGPoint(
                x: center.x + cos(angle) * radius,
                y: center.y + sin(angle) * radius
            )

            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }

        path.closeSubpath()
        return path
    }
}
