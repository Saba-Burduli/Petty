# Rive Asset Pipeline

Petty can support Rive assets, but the runtime should be added as a focused dependency step after full Xcode is available.

## Current State

- The in-app Character Store is live with bundled generated PNG character frames.
- Character selection, size, always-on-top, show/hide, and reset position are persisted.
- Dragging already drives animation intensity through velocity.
- No `.riv` file is rendered yet because the current renderer does not need Rive.

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

1. Install/select full Xcode.
2. Add `https://github.com/rive-app/rive-ios` in Xcode Package Dependencies.
3. Add a `Resources/Rive/` group copied into the app bundle.
4. Import a licensed `.riv` file.
5. Create `RiveCharacterView` behind the same character-store model.
6. Map Petty states to Rive state-machine inputs:
   - idle
   - active
   - bored
   - dragging
   - poked
   - drag speed

This keeps the app running today while leaving a clean path to real Rive-rendered characters.
