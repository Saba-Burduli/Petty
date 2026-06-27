import AppKit
import Foundation

let width = 1920
let height = 1080
let outputDirectory = URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: true)
try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true)

struct Label {
    let text: String
    let x: CGFloat
    let top: CGFloat
    let size: CGFloat
    let color: NSColor
}

struct OverlaySpec {
    let name: String
    let panel: NSRect?
    let panelColor: NSColor
    let labels: [Label]
    let accent: NSRect?
    let fullTint: NSColor?
}

func topRect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> NSRect {
    NSRect(x: x, y: CGFloat(1080) - y - height, width: width, height: height)
}

let white = NSColor.white
let secondary = NSColor(calibratedRed: 0.85, green: 0.89, blue: 0.95, alpha: 1)
let muted = NSColor(calibratedRed: 0.73, green: 0.78, blue: 0.86, alpha: 1)
let green = NSColor(calibratedRed: 0.36, green: 0.89, blue: 0.55, alpha: 1)
let darkPanel = NSColor(calibratedRed: 0.043, green: 0.063, blue: 0.125, alpha: 0.76)

let specs = [
    OverlaySpec(
        name: "00-launch",
        panel: topRect(x: 70, y: 365, width: 930, height: 285),
        panelColor: darkPanel,
        labels: [
            Label(text: "PETTY", x: 96, top: 405, size: 86, color: white),
            Label(text: "A desktop companion for macOS", x: 96, top: 525, size: 42, color: secondary)
        ],
        accent: topRect(x: 96, y: 603, width: 170, height: 7),
        fullTint: nil
    ),
    OverlaySpec(
        name: "01-store",
        panel: topRect(x: 90, y: 320, width: 840, height: 420),
        panelColor: NSColor(calibratedRed: 0.08, green: 0.11, blue: 0.17, alpha: 1),
        labels: [
            Label(text: "ONE STORE.", x: 120, top: 370, size: 74, color: white),
            Label(text: "NINE COMPANIONS.", x: 120, top: 460, size: 74, color: white),
            Label(text: "Switch characters instantly.", x: 120, top: 570, size: 38, color: muted)
        ],
        accent: topRect(x: 120, y: 648, width: 190, height: 7),
        fullTint: nil
    ),
    OverlaySpec(
        name: "02-size75",
        panel: topRect(x: 70, y: 390, width: 850, height: 260),
        panelColor: darkPanel,
        labels: [
            Label(text: "MAKE IT YOUR SIZE", x: 96, top: 425, size: 66, color: white),
            Label(text: "75%", x: 96, top: 515, size: 88, color: green)
        ],
        accent: nil,
        fullTint: nil
    ),
    OverlaySpec(
        name: "03-size135",
        panel: topRect(x: 70, y: 390, width: 850, height: 260),
        panelColor: darkPanel,
        labels: [
            Label(text: "MAKE IT YOUR SIZE", x: 96, top: 425, size: 66, color: white),
            Label(text: "135%", x: 96, top: 515, size: 88, color: green)
        ],
        accent: nil,
        fullTint: nil
    ),
    OverlaySpec(
        name: "04-react",
        panel: topRect(x: 70, y: 390, width: 930, height: 275),
        panelColor: darkPanel,
        labels: [
            Label(text: "REACTS WHILE YOU WORK", x: 96, top: 425, size: 62, color: white),
            Label(text: "Pointer activity, clicks and movement.", x: 96, top: 530, size: 36, color: secondary)
        ],
        accent: topRect(x: 96, y: 612, width: 190, height: 7),
        fullTint: nil
    ),
    OverlaySpec(
        name: "05-rest",
        panel: topRect(x: 70, y: 390, width: 900, height: 275),
        panelColor: darkPanel,
        labels: [
            Label(text: "RESTS WHEN YOU DO", x: 96, top: 425, size: 68, color: white),
            Label(text: "Idle-aware desktop behavior.", x: 96, top: 530, size: 38, color: secondary)
        ],
        accent: topRect(x: 96, y: 612, width: 190, height: 7),
        fullTint: nil
    ),
    OverlaySpec(
        name: "06-end",
        panel: nil,
        panelColor: .clear,
        labels: [
            Label(text: "PETTY FOR macOS", x: 85, top: 425, size: 88, color: white),
            Label(text: "Choose. Place. Work.", x: 85, top: 550, size: 44, color: secondary)
        ],
        accent: topRect(x: 85, y: 657, width: 210, height: 8),
        fullTint: NSColor(calibratedRed: 0.027, green: 0.039, blue: 0.071, alpha: 0.45)
    )
]

for spec in specs {
    guard let bitmap = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: width,
        pixelsHigh: height,
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    ), let context = NSGraphicsContext(bitmapImageRep: bitmap) else {
        fatalError("Could not create overlay bitmap \(spec.name)")
    }

    bitmap.size = NSSize(width: width, height: height)
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = context
    context.cgContext.clear(CGRect(x: 0, y: 0, width: width, height: height))

    if let tint = spec.fullTint {
        tint.setFill()
        NSRect(x: 0, y: 0, width: width, height: height).fill()
    }

    if let panel = spec.panel {
        spec.panelColor.setFill()
        panel.fill()
    }

    if let accent = spec.accent {
        green.setFill()
        accent.fill()
    }

    for label in spec.labels {
        let font = NSFont.systemFont(ofSize: label.size, weight: .bold)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: label.color
        ]
        let textSize = label.text.size(withAttributes: attributes)
        label.text.draw(
            at: NSPoint(x: label.x, y: CGFloat(height) - label.top - textSize.height),
            withAttributes: attributes
        )
    }

    NSGraphicsContext.restoreGraphicsState()

    guard let png = bitmap.representation(using: .png, properties: [:]) else {
        fatalError("Could not render overlay \(spec.name)")
    }

    try png.write(to: outputDirectory.appendingPathComponent("\(spec.name).png"))
}
