import AppKit
import Foundation

private let canvasWidth = 1920
private let canvasHeight = 1080

guard CommandLine.arguments.count == 2 else {
    fputs("usage: make_title_overlays_v2.swift OUTPUT_DIRECTORY\n", stderr)
    exit(64)
}

let outputDirectory = URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: true)
try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true)

struct TextLine {
    let text: String
    let top: CGFloat
    let size: CGFloat
    let color: NSColor
    let weight: NSFont.Weight
}

struct Overlay {
    let filename: String
    let kicker: String
    let lines: [TextLine]
    let tintAlpha: CGFloat
}

let white = NSColor(calibratedWhite: 0.98, alpha: 1)
let secondary = NSColor(calibratedWhite: 0.86, alpha: 1)
let green = NSColor(calibratedRed: 0.31, green: 0.91, blue: 0.52, alpha: 1)
let x: CGFloat = 92

let overlays: [Overlay] = [
    Overlay(
        filename: "00-meet",
        kicker: "NATIVE FOR macOS",
        lines: [
            TextLine(text: "MEET PETTY", top: 500, size: 82, color: white, weight: .heavy)
        ],
        tintAlpha: 0
    ),
    Overlay(
        filename: "01-choose",
        kicker: "CHARACTER STORE",
        lines: [
            TextLine(text: "CHOOSE YOUR", top: 470, size: 70, color: white, weight: .heavy),
            TextLine(text: "COMPANION", top: 552, size: 70, color: white, weight: .heavy)
        ],
        tintAlpha: 0
    ),
    Overlay(
        filename: "02-nine",
        kicker: "BUILT-IN COLLECTION",
        lines: [
            TextLine(text: "9 CHARACTERS.", top: 470, size: 68, color: white, weight: .heavy),
            TextLine(text: "ONE DESKTOP.", top: 550, size: 68, color: white, weight: .heavy)
        ],
        tintAlpha: 0
    ),
    Overlay(
        filename: "03-drag",
        kicker: "SLOW OR FAST",
        lines: [
            TextLine(text: "DRAG IT", top: 470, size: 74, color: white, weight: .heavy),
            TextLine(text: "ANYWHERE", top: 556, size: 74, color: white, weight: .heavy)
        ],
        tintAlpha: 0
    ),
    Overlay(
        filename: "04-size",
        kicker: "75%  /  100%  /  135%",
        lines: [
            TextLine(text: "MAKE IT", top: 470, size: 74, color: white, weight: .heavy),
            TextLine(text: "YOUR SIZE", top: 556, size: 74, color: white, weight: .heavy)
        ],
        tintAlpha: 0
    ),
    Overlay(
        filename: "05-click",
        kicker: "REAL CHARACTER REACTIONS",
        lines: [
            TextLine(text: "CLICK FOR A", top: 470, size: 70, color: white, weight: .heavy),
            TextLine(text: "REACTION", top: 552, size: 70, color: white, weight: .heavy)
        ],
        tintAlpha: 0
    ),
    Overlay(
        filename: "06-work",
        kicker: "POINTER + KEYBOARD ACTIVITY",
        lines: [
            TextLine(text: "IT MOVES WHILE", top: 470, size: 66, color: white, weight: .heavy),
            TextLine(text: "YOU WORK", top: 548, size: 66, color: white, weight: .heavy)
        ],
        tintAlpha: 0
    ),
    Overlay(
        filename: "07-rest",
        kicker: "IDLE-AWARE",
        lines: [
            TextLine(text: "AND RESTS", top: 470, size: 72, color: white, weight: .heavy),
            TextLine(text: "WHEN YOU DO", top: 554, size: 72, color: white, weight: .heavy)
        ],
        tintAlpha: 0
    ),
    Overlay(
        filename: "08-switch",
        kicker: "NINE DISTINCT COMPANIONS",
        lines: [
            TextLine(text: "SWITCH", top: 470, size: 78, color: white, weight: .heavy),
            TextLine(text: "ANYTIME", top: 560, size: 78, color: white, weight: .heavy)
        ],
        tintAlpha: 0
    ),
    Overlay(
        filename: "09-end",
        kicker: "PETTY FOR macOS",
        lines: [
            TextLine(text: "PETTY IS", top: 405, size: 82, color: white, weight: .heavy),
            TextLine(text: "OPEN SOURCE", top: 500, size: 82, color: white, weight: .heavy),
            TextLine(text: "STAR ON GITHUB", top: 620, size: 40, color: green, weight: .bold),
            TextLine(text: "github.com/Saba-Burduli/Petty", top: 684, size: 30, color: secondary, weight: .semibold)
        ],
        tintAlpha: 0.24
    )
]

func draw(_ text: String, at point: NSPoint, size: CGFloat, color: NSColor, weight: NSFont.Weight) {
    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.72)
    shadow.shadowBlurRadius = 18
    shadow.shadowOffset = NSSize(width: 0, height: -3)

    let attributes: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: size, weight: weight),
        .foregroundColor: color,
        .kern: 0,
        .shadow: shadow
    ]
    text.draw(at: point, withAttributes: attributes)
}

for overlay in overlays {
    let kickerTop: CGFloat = overlay.filename == "09-end" ? 300 : 390
    guard let bitmap = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: canvasWidth,
        pixelsHigh: canvasHeight,
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    ), let context = NSGraphicsContext(bitmapImageRep: bitmap) else {
        fatalError("Unable to create overlay bitmap")
    }

    bitmap.size = NSSize(width: canvasWidth, height: canvasHeight)
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = context
    context.cgContext.clear(CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))

    if overlay.tintAlpha > 0 {
        NSColor.black.withAlphaComponent(overlay.tintAlpha).setFill()
        NSRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight).fill()
    }

    draw(
        overlay.kicker,
        at: NSPoint(x: x, y: CGFloat(canvasHeight) - kickerTop - 28),
        size: 24,
        color: green,
        weight: .bold
    )

    green.setFill()
    NSRect(x: x, y: CGFloat(canvasHeight) - kickerTop - 48, width: 64, height: 5).fill()

    for line in overlay.lines {
        draw(
            line.text,
            at: NSPoint(x: x, y: CGFloat(canvasHeight) - line.top - line.size),
            size: line.size,
            color: line.color,
            weight: line.weight
        )
    }

    NSGraphicsContext.restoreGraphicsState()

    guard let png = bitmap.representation(using: .png, properties: [:]) else {
        fatalError("Unable to encode overlay \(overlay.filename)")
    }
    try png.write(to: outputDirectory.appendingPathComponent("\(overlay.filename).png"))
}

print("Rendered \(overlays.count) overlays to \(outputDirectory.path)")
