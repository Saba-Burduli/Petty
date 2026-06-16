import AppKit

final class ActivityMonitor {
    private let onIdleTimeChanged: (TimeInterval) -> Void
    private var timer: Timer?

    init(onIdleTimeChanged: @escaping (TimeInterval) -> Void) {
        self.onIdleTimeChanged = onIdleTimeChanged
    }

    func start() {
        stop()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            let idleSeconds = CGEventSource.secondsSinceLastEventType(
                .combinedSessionState,
                eventType: .mouseMoved
            )
            self.onIdleTimeChanged(idleSeconds)
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
