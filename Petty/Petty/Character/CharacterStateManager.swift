import Combine
import Foundation

@MainActor
final class CharacterStateManager: ObservableObject {
    @Published private(set) var state: CharacterState = .idle

    private var previousNonDraggingState: CharacterState = .idle
    private var pokeResetTask: Task<Void, Never>?

    func update(idleSeconds: TimeInterval) {
        guard state != .dragging, state != .poked else { return }

        let nextState: CharacterState
        if idleSeconds < 2 {
            nextState = .active
        } else if idleSeconds > 12 {
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
        state = .dragging
    }

    func endDragging() {
        state = previousNonDraggingState
    }

    func poke() {
        guard state != .dragging else { return }
        previousNonDraggingState = state == .poked ? previousNonDraggingState : state
        state = .poked

        pokeResetTask?.cancel()
        pokeResetTask = Task { [weak self] in
            try? await Task.sleep(for: .seconds(1.2))
            guard !Task.isCancelled else { return }
            await MainActor.run {
                guard let self, self.state == .poked else { return }
                self.state = self.previousNonDraggingState
            }
        }
    }

    private func setNonDraggingState(_ nextState: CharacterState) {
        state = nextState
        previousNonDraggingState = nextState
    }
}
