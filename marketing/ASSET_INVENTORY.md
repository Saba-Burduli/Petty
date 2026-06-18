# Petty Asset Inventory

## Scope

This inventory documents the existing macOS app and its current local assets.
It does not propose or implement new app features or final marketing media.

## App Asset Structure

The active character library is stored at:

```text
Petty/Petty/Resources/Characters/
```

Each bundled character has this structure:

```text
CharacterFolder/
  manifest.json
  ATTRIBUTION.md
  Frames/
    Idle/
    Walk/
    Attack/
    Dead/ or Sleep/
```

`manifest.json` defines the store name, source, sort order, frame count, frame
rate, loop behavior, and the folder used for each animation state.

The Xcode project copies the complete `Petty/Petty/Resources` folder into the
app bundle. The app can also discover user-installed packs from:

```text
~/Library/Application Support/Petty/Characters/
```

## Formats

- Active runtime character art: transparent PNG frame sequences.
- Character metadata: JSON manifests.
- Source and license tracking: Markdown attribution files.
- Bundled character files counted during inspection: 410 PNG, 9 JSON, 9
  Markdown files.
- No active SVG, GIF, Lottie, spritesheet, or `.riv` character file is bundled.
- `RiveRuntime` is linked through Swift Package Manager as an optional future
  renderer, but the current desktop companion uses PNG sequences.
- Some source packs originated as spritesheets or SVG files, but they were
  converted into numbered PNG frames for runtime use.

Frame filenames use this pattern:

```text
<Folder>_<three-digit frame number>.png
```

Example:

```text
Frames/Idle/Idle_001.png
```

## Character Inventory

There are **9 bundled characters** and **4 animation slots per character**.
Manifest frame counts match the files present on disk.

| Character | Resource folder | Idle | Walk / active | Attack / poke | Sleep / bored | Source |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| Tux | `SuperTuxTux` | 12 PNG @ 12 FPS, loop | 8 PNG @ 14 FPS, loop | 6 PNG @ 16 FPS, loop | 5 PNG @ 5 FPS, one-shot (`Sleep`) | SuperTux project data |
| Surge | `OpenSurgeSurge` | 60 PNG @ 8 FPS, loop | 8 PNG @ 18 FPS, loop | 12 PNG @ 20 FPS, loop | 3 PNG @ 5 FPS, one-shot (`Sleep`) | Open Surge |
| Redcap Runner | `GameArt2DRedHatBoy` | 10 PNG @ 8 FPS, loop | 8 PNG @ 12 FPS, loop | 12 PNG @ 14 FPS, loop | 10 PNG @ 4 FPS, one-shot (`Dead`) | OpenGameArt / GameArt2D CC0 |
| Graveyard Intern | `GameArt2DZombie` | 15 PNG @ 7 FPS, loop | 10 PNG @ 10 FPS, loop | 8 PNG @ 14 FPS, loop | 12 PNG @ 4 FPS, one-shot (`Dead`) | OpenGameArt / GameArt2D CC0 |
| Cyberpunk Ninja | `PincholincoCyberpunkNinja` | 7 PNG @ 7 FPS, loop | 12 PNG @ 12 FPS, loop | 6 PNG @ 12 FPS, loop | 3 PNG @ 4 FPS, one-shot (`Dead`) | Pincholinco, CC BY 4.0 |
| Ironkeep Sentinel | `GameArt2DKnight` | 10 PNG @ 7 FPS, loop | 10 PNG @ 10 FPS, loop | 10 PNG @ 14 FPS, loop | 10 PNG @ 4 FPS, one-shot (`Dead`) | GameArt2D CC0 |
| Storm Trooper | `WKStudioStormTrooper` | 20 PNG @ 8 FPS, loop | 20 PNG @ 12 FPS, loop | 8 PNG @ 12 FPS, loop | 20 PNG @ 8 FPS, one-shot (`Dead`) | W_K_Studio, CC0 |
| Shadowbyte Kunoichi | `GameArt2DNinjaGirl` | 10 PNG @ 7 FPS, loop | 10 PNG @ 12 FPS, loop | 10 PNG @ 14 FPS, loop | 10 PNG @ 4 FPS, one-shot (`Dead`) | GameArt2D CC0 |
| Relic Scout | `GameArt2DAdventurerGirl` | 10 PNG @ 7 FPS, loop | 8 PNG @ 10 FPS, loop | 7 PNG @ 13 FPS, loop | 10 PNG @ 4 FPS, one-shot (`Dead`) | GameArt2D CC0 |

Attribution and original source URLs are stored beside each pack in
`ATTRIBUTION.md`.

## Runtime States and Emotes

The app exposes these behavioral states:

| App state | Animation slot | Trigger |
| --- | --- | --- |
| `idle` | Idle | No recent input, before bored threshold |
| `active` | Walk | System activity; typing uses a faster playback rate |
| `bored` | Sleep/Dead | More than 18 seconds of system idle time |
| `poked` | Attack | Character click/poke for approximately 1.2 seconds |
| `dragging` | Walk | Window drag; playback speed, scale, rotation, and vertical offset respond to drag speed |

The renderer updates through a SwiftUI `TimelineView` with a 24 FPS minimum
interval. Looping states wrap through their frame sequence; sleep/dead states
stop on the final frame.

Primary implementation files:

```text
Petty/Petty/Character/CharacterAsset.swift
Petty/Petty/Character/CharacterView.swift
Petty/Petty/Character/CharacterStateManager.swift
Petty/Petty/Activity/ActivityMonitor.swift
```

## Preview and Documentation Assets

### In-app previews

The Character Store does not use separate thumbnail files. It loads frame 1 of
each character's idle sequence through `CharacterImageLoader.previewImage`.

Implementation:

```text
Petty/Petty/Settings/SettingsView.swift
Petty/Petty/Character/CharacterView.swift
```

### Repository preview images

These are the retained 1280x720 character-asset documentation images:

```text
docs/media/petty-assets-lineup.png
docs/media/petty-asset-zombie.png
docs/media/petty-asset-knight.png
docs/media/petty-asset-storm-trooper.png
docs/media/petty-asset-ninja-girl.png
docs/media/petty-asset-adventurer.png
```

The repository currently has no retained trailer, demo GIF, MP4, raw desktop
recording, or live desktop screenshot.

### App icon

No app-specific `.xcassets` catalog, `.icns` file, or standalone app icon was
found under `Petty/Petty`.

## Best Existing Assets for a Future Trailer or Showcase

Use the source PNG frames directly rather than extracting frames from old
showcase media.

1. `docs/media/petty-assets-lineup.png` is the best existing static overview.
2. The five `docs/media/petty-asset-*.png` files are the best existing
   state-comparison images.
3. For motion capture, use each character's complete `Idle`, `Walk`, `Attack`,
   and `Sleep`/`Dead` frame folders.
4. Tux, Surge, and Storm Trooper have especially recognizable silhouettes at
   small desktop scale.
5. Graveyard Intern has the longest non-Surge idle sequence and clear
   idle/walk/attack/sleep differentiation.
6. The GameArt2D characters have larger source frames and are suitable for
   close-up store or state-transition captures.

Representative first idle frames range from 64x64 for Surge to 587x707 for
Ironkeep Sentinel. The renderer scales all characters into a 190x205 display
area, so future capture should verify both native-size close-ups and actual
desktop-size readability.

## Existing Marketing or Landing Work

An existing landing-page folder is present:

```text
landing/
```

The current local worktree contains an in-progress React 18, TypeScript, and
Vite conversion with:

```text
landing/src/App.tsx
landing/src/main.tsx
landing/src/styles.css
landing/public/characters/
landing/package.json
landing/vite.config.ts
```

`landing/public/characters/` contains copied idle PNG sequences for use by the
landing page. These files are separate from the authoritative app assets in
`Petty/Petty/Resources/Characters`.

Important: the landing conversion and `.gitignore` changes were already
uncommitted during this inventory task. They were inspected but not modified or
included in the inventory commit.

There was no existing `marketing/` folder before this document.

## Missing Marketing Assets

Potential future needs, without creating them in this task:

- A clean current app screenshot on a neutral macOS desktop.
- A short current screen recording showing store selection, idle, active,
  poke, drag-speed response, and bored/sleep transitions.
- A dedicated app icon and export sizes.
- A consistent wordmark or small brand lockup.
- Current Character Store screenshots at desktop and compact window sizes.
- Transparent hero cutouts selected from source frames.
- A shot list and approved reference direction for any new trailer.
- Final marketing copy, feature captions, and accessibility alt text.
- A license/attribution pass before publishing character-focused marketing,
  especially for CC BY, CC-BY-SA, and recognizable third-party characters.
- A decision on whether the existing `landing/` work becomes the official
  marketing site.

## Run and Build Notes

Requirements visible in the project:

- Xcode with macOS SDK.
- macOS deployment target 14.0.
- Swift 5.
- Swift Package Manager access to the `rive-ios` package.
- Xcode project: `Petty/Petty.xcodeproj`.
- Scheme: `Petty`.
- Bundle identifier: `com.sababurduli.Petty`.

Open and run in Xcode:

```bash
open Petty/Petty.xcodeproj
```

Select the `Petty` scheme and run the macOS target.

Build and launch from the repository root:

```bash
./script/build_and_run.sh
```

The script:

1. Stops an existing `Petty` process.
2. Runs `xcodebuild` with the Debug configuration.
3. Writes derived data to `build/DerivedData`.
4. Opens `build/DerivedData/Build/Products/Debug/Petty.app`.
5. Verifies that the `Petty` process remains running.

Other supported script modes:

```bash
./script/build_and_run.sh --verify
./script/build_and_run.sh --debug
./script/build_and_run.sh --logs
./script/build_and_run.sh --telemetry
```

The build command used by the script is equivalent to:

```bash
xcodebuild \
  -project Petty/Petty.xcodeproj \
  -scheme Petty \
  -configuration Debug \
  -derivedDataPath build/DerivedData \
  build
```

## Files Inspected

Key files and directories inspected for this inventory:

```text
README.md
Petty/Petty.xcodeproj/project.pbxproj
Petty/Petty/Resources/Characters/
Petty/Petty/Character/CharacterAsset.swift
Petty/Petty/Character/CharacterView.swift
Petty/Petty/Character/CharacterState.swift
Petty/Petty/Character/CharacterStateManager.swift
Petty/Petty/Activity/ActivityMonitor.swift
Petty/Petty/Settings/SettingsView.swift
script/build_and_run.sh
docs/ASSET_PACKS.md
docs/RIVE_ASSET_PIPELINE.md
docs/XCODE_RIVE_SETUP.md
docs/media/
landing/
```
