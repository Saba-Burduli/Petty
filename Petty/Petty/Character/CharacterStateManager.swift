import Combine
import Foundation

@MainActor
final class CharacterStateManager: ObservableObject {
    @Published private(set) var state: CharacterState = .idle
    @Published private(set) var dragSpeed: CGFloat = 0
    @Published private(set) var activityKind: CharacterActivityKind = .none

    private var previousNonDraggingState: CharacterState = .idle
    private var pokeResetTask: Task<Void, Never>?
    private var stateChangedAt = Date()

    func update(activity: ActivitySnapshot) {
        guard state != .dragging, state != .poked else { return }

        activityKind = currentActivityKind(from: activity)

        let nextState: CharacterState
        if activity.systemIdleSeconds < 1.4 {
            nextState = .active
        } else if activity.systemIdleSeconds > 18 {
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
        activityKind = .pointer
        setState(.dragging)
    }

    func updateDragSpeed(pointsPerSecond: CGFloat) {
        dragSpeed = min(max(pointsPerSecond / 1800, 0), 1)
    }

    func endDragging() {
        dragSpeed = 0
        activityKind = .none
        setState(previousNonDraggingState)
    }

    func poke() {
        guard state != .dragging else { return }
        previousNonDraggingState = state == .poked ? previousNonDraggingState : state
        activityKind = .pointer
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

    private func currentActivityKind(from activity: ActivitySnapshot) -> CharacterActivityKind {
        if activity.keyboardIdleSeconds < 0.9 {
            return .typing
        }
        if activity.pointerIdleSeconds < 0.9 {
            return .pointer
        }
        return .none
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
