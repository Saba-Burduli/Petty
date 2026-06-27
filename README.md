# Petty

Petty is a native macOS prototype for a tiny animated desktop companion. The current prototype uses sourced 2D character sprite assets with authored frame animations.

The standalone website is maintained in
[Petty-Landing](https://github.com/Saba-Burduli/Petty-Landing).

## Trailer

[![Petty 30-second trailer](docs/media/trailers/petty-launch-trailer-preview.gif)](docs/media/trailers/petty-launch-trailer-30s.mp4)

- [Landscape trailer](docs/media/trailers/petty-launch-trailer-30s.mp4)
- [Square trailer](docs/media/trailers/petty-launch-trailer-square.mp4)
- [Vertical trailer](docs/media/trailers/petty-launch-trailer-vertical.mp4)

## Character Assets

![Petty asset lineup](docs/media/petty-assets-lineup.png)

The bundled store now includes sourced character packs from open game projects, free asset stores, and itch.io:

- Tux from SuperTux.
- Surge from Open Surge.
- Storm Trooper from W_K_Studio's CC0 itch.io sprite pack.
- Redcap Runner from an OpenGameArt/GameArt2D CC0 pack.
- Cyberpunk Ninja from Pincholinco's CC BY 4.0 itch.io sprite pack.
- Graveyard Intern from an OpenGameArt/GameArt2D CC0 pack.
- Ironkeep Sentinel from a GameArt2D CC0 pack.
- Shadowbyte Kunoichi from a GameArt2D CC0 pack.
- Relic Scout from a GameArt2D CC0 pack.

It also includes the earlier GameArt2D/OpenGameArt packs that remain in the store:

| Graveyard Intern | Ironkeep Sentinel | Storm Trooper |
| --- | --- | --- |
| ![Graveyard Intern asset states](docs/media/petty-asset-zombie.png) | ![Ironkeep Sentinel asset states](docs/media/petty-asset-knight.png) | ![Storm Trooper asset states](docs/media/petty-asset-storm-trooper.png) |

| Shadowbyte Kunoichi | Relic Scout |
| --- | --- |
| ![Shadowbyte Kunoichi asset states](docs/media/petty-asset-ninja-girl.png) | ![Relic Scout asset states](docs/media/petty-asset-adventurer.png) |

## Current Prototype Features

- Transparent, borderless character window.
- Floating always-on-top mode.
- Menu bar controls for show, hide, reset position, always-on-top, and quit.
- Store & Settings window with bundled SuperTux, Open Surge, GameArt2D, and OpenGameArt character assets.
- Drop-in bundled character packs loaded from per-character manifests.
- Drag-to-move behavior.
- Drag-speed-reactive animation playback.
- Authored PNG sequence rendering for idle, walk/run, attack, and sleepy/dead states.
- Saved and restored character position.
- Basic states: idle, active, bored, and dragging.
- Privacy-safe activity detection using system idle time plus keyboard/pointer event timing.

## How To Run Locally

Open the project in Xcode:

```sh
open Petty/Petty.xcodeproj
```

Then select the `Petty` scheme and run the macOS app.

Or use the project run script:

```sh
./script/build_and_run.sh
```

## Adding Character Packs

Petty now discovers bundled character folders from `Petty/Petty/Resources/Characters`. Add a folder with PNG sequence frames, `ATTRIBUTION.md`, and `manifest.json`; the app loads it into the Store & Settings character picker automatically on next build.

See [docs/ASSET_PACKS.md](docs/ASSET_PACKS.md) for the expected folder layout and manifest schema.

See [docs/ASSET_RESEARCH.md](docs/ASSET_RESEARCH.md) for the official-source asset research notes.

## Current Limitations

- The current character is an authored PNG sequence asset, not a skeletal Rive/Spine rig.
- Rive is integrated as an optional future runtime path, but the current desktop pet uses PNG frame animation.
- No remote marketplace, backend, accounts, payments, telemetry, AI chat, or cloud sync.
- Fullscreen and Spaces behavior may vary by macOS version and user window settings.
- Activity detection does not inspect typed text or app content.

## Next Steps

- Add a true skeletal asset pack, such as Rive or Spine, when a production-ready rig is available.
- Add a minimal settings window for opacity, visibility mode, and size.
- Add smarter visibility modes such as Desktop Only, Focus Mode, and Pause During Fullscreen.
- Add a character data model for future collectible packs.
- Package the app for easier local testing.
