import Combine
import Foundation

@MainActor
final class CharacterStateManager: ObservableObject {
    @Published private(set) var state: CharacterState = .idle
    @Published private(set) var dragSpeed: CGFloat = 0

    private var previousNonDraggingState: CharacterState = .idle
    private var pokeResetTask: Task<Void, Never>?
    private var stateChangedAt = Date()

    func update(idleSeconds: TimeInterval) {
        guard state != .dragging, state != .poked else { return }

        let nextState: CharacterState
        if idleSeconds < 1.4 {
            nextState = .active
        } else if idleSeconds > 18 {
            nextState = .bored
        } else {
            nextState = .idle
        }

        setNonDraggingState(nextState)
    }

    func beginDragging() {
        if state != .dragging {
            previousNonDraggingState = state
        }
        setState(.dragging)
    }

    func updateDragSpeed(pointsPerSecond: CGFloat) {
        dragSpeed = min(max(pointsPerSecond / 1800, 0), 1)
    }

    func endDragging() {
        dragSpeed = 0
        setState(previousNonDraggingState)
    }

    func poke() {
        guard state != .dragging else { return }
        previousNonDraggingState = state == .poked ? previousNonDraggingState : state
        setState(.poked)

        pokeResetTask?.cancel()
        pokeResetTask = Task { [weak self] in
            try? await Task.sleep(for: .seconds(1.2))
            guard !Task.isCancelled else { return }
            await MainActor.run {
                guard let self, self.state == .poked else { return }
                self.setState(self.previousNonDraggingState)
            }
        }
    }

    private func setNonDraggingState(_ nextState: CharacterState) {
        guard shouldTransition(to: nextState) else { return }
        setState(nextState)
        previousNonDraggingState = nextState
    }

    private func shouldTransition(to nextState: CharacterState) -> Bool {
        guard nextState != state else { return false }

        let elapsed = Date().timeIntervalSince(stateChangedAt)
        switch (state, nextState) {
        case (.active, .idle):
            return elapsed > 2.2
        case (.idle, .active):
            return elapsed > 0.6
        case (.idle, .bored):
            return elapsed > 4
        case (.bored, .idle), (.bored, .active):
            return true
        default:
            return elapsed > 1
        }
    }

    private func setState(_ nextState: CharacterState) {
        guard state != nextState else { return }
        state = nextState
        stateChangedAt = Date()
    }
}
