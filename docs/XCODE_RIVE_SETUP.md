# Xcode and Rive Setup

## Current Status

- `mas` is installed through Homebrew.
- `xcodes` could not be installed because this Mac only has Command Line Tools and is missing Apple's full Xcode build support.
- Full Xcode is not installed at `/Applications/Xcode.app`.
- `xcodebuild` is still blocked because `xcode-select` points at `/Library/Developer/CommandLineTools`.
- The Petty Xcode project now references the official Rive Apple runtime package:

```text
https://github.com/rive-app/rive-ios
```

Product:

```text
RiveRuntime
```

## Blocker

The App Store CLI can see Xcode, but installing it requires a local sudo password prompt:

```text
sudo: a terminal is required to read the password
```

Codex cannot provide the user's macOS password in this non-interactive session.

## Manual Step

Install Xcode with one of these:

```sh
mas get 497799835
```

or open the App Store page and install Xcode:

```sh
mas open 497799835
```

After installation:

```sh
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
xcodebuild -project Petty/Petty.xcodeproj -scheme Petty -resolvePackageDependencies
xcodebuild -project Petty/Petty.xcodeproj -scheme Petty -configuration Debug build
```

Once that succeeds, Petty can replace the PNG renderer with a `RiveRuntime` renderer and wire `.riv` state-machine inputs to activity, idle, poke, and drag speed.
