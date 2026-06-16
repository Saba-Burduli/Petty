# Xcode and Rive Setup

## Current Status

- `mas` is installed through Homebrew.
- Full Xcode is installed at `/Applications/Xcode.app`.
- `xcode-select` points at `/Applications/Xcode.app/Contents/Developer`.
- `xcodebuild -runFirstLaunch` has completed.
- `xcodebuild` can resolve packages and build Petty.
- The Petty Xcode project now references the official Rive Apple runtime package:

```text
https://github.com/rive-app/rive-ios
```

Product:

```text
RiveRuntime
```

## Verified Commands

```sh
xcodebuild -project Petty/Petty.xcodeproj -scheme Petty -resolvePackageDependencies
xcodebuild -project Petty/Petty.xcodeproj -scheme Petty -configuration Debug build
```

Both commands succeed. Petty now has a `RiveRuntime` renderer path and can render a bundled `.riv` file. The remaining product step is to replace the proof `.riv` file with an original Petty zombie rig and wire its specific state-machine inputs to activity, idle, poke, and drag speed.
