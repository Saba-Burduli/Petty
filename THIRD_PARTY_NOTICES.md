# Third-Party Notices

Petty includes third-party dependencies and character assets. Petty's MIT
license applies only to original Petty source code and does not replace the
licenses listed below.

## Runtime Dependency

### Rive iOS Runtime

- Project: https://github.com/rive-app/rive-ios
- Version: 6.20.6, pinned in `Package.resolved`
- License: MIT

## Bundled Character Assets

| Pack | Upstream source | License or source notice |
| --- | --- | --- |
| Tux | [SuperTux](https://github.com/SuperTux/supertux) | SuperTux is GPLv3; its README states that most data assets are CC BY-SA. See the bundled attribution file before redistribution. |
| Surge | [Open Surge](https://github.com/alemart/opensurge) | Upstream project asset notices apply; the imported sprite definition identifies Alexandre Martins and the MIT license. |
| Redcap Runner | [Red Hat Boy on OpenGameArt](https://opengameart.org/content/red-hat-boy-free-sprites) | CC0; author listed as pzUH. |
| Graveyard Intern | [Zombie on OpenGameArt](https://opengameart.org/content/the-zombie-free-sprites) | CC0; author listed as pzUH. |
| Ironkeep Sentinel | [The Knight by GameArt2D](https://www.gameart2d.com/the-knight-free-sprites.html) | CC0 / public-domain freebie notice. |
| Shadowbyte Kunoichi | [Ninja Girl by GameArt2D](https://www.gameart2d.com/ninja-girl---free-sprites.html) | CC0 / public-domain freebie notice. |
| Relic Scout | [Adventurer Girl by GameArt2D](https://www.gameart2d.com/adventurer-girl---free-sprites.html) | CC0 / public-domain freebie notice. |
| Cyberpunk Ninja | [Cyberpunk Ninja by Pincholinco](https://pincholinco.itch.io/ninja-character-sprite) | Creative Commons Attribution 4.0 International. |
| Storm Trooper | [W_K_Studio sprite pack](https://whiteknightstudios.itch.io/old-school-fps-8d-trooper-v3) | Creative Commons Zero 1.0 Universal, as stated on the source page. |

Every bundled pack also contains an `ATTRIBUTION.md` next to its
`manifest.json` under `Petty/Petty/Resources/Characters`. Those files are the
authoritative repository-local record for the imported files and animation
mapping.

Names and trademarks remain the property of their respective owners. Inclusion
in Petty does not imply endorsement by an upstream project or artist.
