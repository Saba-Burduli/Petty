import AppKit
import IOKit

final class ActivityMonitor {
    private let onIdleTimeChanged: (TimeInterval) -> Void
    private var timer: Timer?

    init(onIdleTimeChanged: @escaping (TimeInterval) -> Void) {
        self.onIdleTimeChanged = onIdleTimeChanged
    }

    func start() {
        stop()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.onIdleTimeChanged(systemIdleSeconds())
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}

private func systemIdleSeconds() -> TimeInterval {
    var iterator: io_iterator_t = 0
    let result = IOServiceGetMatchingServices(
        kIOMainPortDefault,
        IOServiceMatching("IOHIDSystem"),
        &iterator
    )
    guard result == KERN_SUCCESS else { return 0 }
    defer { IOObjectRelease(iterator) }

    let entry = IOIteratorNext(iterator)
    guard entry != 0 else { return 0 }
    defer { IOObjectRelease(entry) }

    var properties: Unmanaged<CFMutableDictionary>?
    let propertiesResult = IORegistryEntryCreateCFProperties(entry, &properties, kCFAllocatorDefault, 0)
    guard propertiesResult == KERN_SUCCESS, let properties else { return 0 }

    let dictionary = properties.takeRetainedValue() as NSDictionary
    guard let idleNanoseconds = dictionary["HIDIdleTime"] as? UInt64 else { return 0 }
    return TimeInterval(idleNanoseconds) / 1_000_000_000
}
