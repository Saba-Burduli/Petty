# Petty

Petty is a native macOS prototype for a tiny animated desktop companion. The first placeholder character is Petty, an original productivity gym creature that reacts while the user works.

## Current Prototype Features

- Transparent, borderless character window.
- Floating always-on-top mode.
- Menu bar controls for show, hide, reset position, always-on-top, and quit.
- Store & Settings window with the bundled Zed character asset.
- Drag-to-move behavior.
- Drag-speed-reactive animation.
- Layered PNG rig rendering with independently animated head, body, eyelids, and shadow.
- Live procedural emotion animation for idle, active, sleepy, poked, and dragging states.
- Saved and restored character position.
- Basic states: idle, active, bored, and dragging.
- Privacy-safe activity detection using coarse idle time only.

## How To Run Locally

Open the project in Xcode:

```sh
open Petty/Petty.xcodeproj
```

Then select the `Petty` scheme and run the macOS app.

This environment only has Command Line Tools selected, so `xcodebuild` cannot run until full Xcode is installed or selected:

```sh
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
xcodebuild -project Petty/Petty.xcodeproj -scheme Petty -configuration Debug build
```

## Current Limitations

- The current character is generated concept art split into rig layers, not final polished production art.
- Rive is integrated as an optional future runtime path, but the current desktop pet uses the custom layered PNG rig.
- No remote marketplace, backend, accounts, payments, telemetry, AI chat, or cloud sync.
- Fullscreen and Spaces behavior may vary by macOS version and user window settings.
- Activity detection is intentionally coarse and does not inspect typed text or app content.

## Next Steps

- Add original character art and better animation states.
- Add a minimal settings window for opacity, visibility mode, and size.
- Add smarter visibility modes such as Desktop Only, Focus Mode, and Pause During Fullscreen.
- Add a character data model for future collectible packs.
- Package the app for easier local testing.
