# Rive Asset Pipeline

Petty can support Rive assets. The Xcode project already references the official Rive Apple runtime package, but dependency resolution requires full Xcode to be installed and selected.

## Current State

- The in-app Character Store is live with bundled generated PNG character frames.
- The Xcode project resolves and links `RiveRuntime`.
- Petty can render a bundled `.riv` file in the desktop character window.
- The current `.riv` file is a runtime proof asset, not the final original Petty zombie rig.
- Character selection, size, always-on-top, show/hide, and reset position are persisted.
- Dragging already drives animation intensity through velocity.
- A `.riv` file is rendered now. The next step is replacing the proof asset with an original Petty zombie rig.

## Rive Runtime

Rive publishes an Apple runtime for iOS, macOS, tvOS, and visionOS. The official repository says it supports AppKit and SwiftUI and is distributed through Swift Package Manager and CocoaPods.

Package URL:

```text
https://github.com/rive-app/rive-ios
```

## Marketplace Candidate

The Rive marketplace file "Animated Icon Set - 1 Color" is CC BY and includes idle/active state-machine-controlled icons. It is a good technical reference for state-machine animation, but it is not a final Petty character.

Reference:

```text
https://rive.app/community/files/1298-2487-animated-icon-set-1-color/
```

## Recommended Next Implementation Step

1. Author or import an original Petty zombie `.riv` rig.
2. Add it to the app bundle.
3. Replace the runtime proof asset.
4. Map Petty states to Rive state-machine inputs:
   - idle
   - active
   - bored
   - dragging
   - poked
   - drag speed

This keeps the app running today while leaving a clean path to the final Rive-rigged Petty character.
