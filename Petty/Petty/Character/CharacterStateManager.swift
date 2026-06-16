import Combine
import Foundation

@MainActor
final class CharacterStateManager: ObservableObject {
    @Published private(set) var state: CharacterState = .idle

    private var previousNonDraggingState: CharacterState = .idle

    func update(idleSeconds: TimeInterval) {
        guard state != .dragging else { return }

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

    private func setNonDraggingState(_ nextState: CharacterState) {
        state = nextState
        previousNonDraggingState = nextState
    }
}
