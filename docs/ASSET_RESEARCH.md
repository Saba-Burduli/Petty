# Asset Research

This file tracks recognizable character candidates checked against official or primary sources before bundling.

## Imported

### Tux from SuperTux

- Official source: https://github.com/SuperTux/supertux
- Official project: https://www.supertux.org/
- Why it fits: recognizable open-source game mascot with real authored frame animations.
- License finding: the SuperTux README says the project is GPLv3 and that most of the `data` directory is also CC-BY-SA.
- Imported as: `Petty/Petty/Resources/Characters/SuperTuxTux`

### Surge from Open Surge

- Official source: https://github.com/alemart/opensurge
- Official project: https://opensurge2d.org/
- Why it fits: recognizable character from an open-source Sonic-like platformer, with a full official sprite sheet and animation definition.
- License finding: the official Open Surge site says the engine includes ready-to-use game assets under Creative Commons licenses; the `sprites/players/surge.spr` file lists MIT for the sprite definition.
- Imported as: `Petty/Petty/Resources/Characters/OpenSurgeSurge`

## Researched But Not Imported

### Commercial Franchise List From June 17 Research

The following popular commercial franchises were checked against official or primary sources. None currently meet Petty's import bar: a clear, public license that allows bundling reusable character/game assets inside Petty's selectable character store.

| Franchise | Official source checked | Finding | Petty decision |
| --- | --- | --- | --- |
| God of War | Sony Interactive Entertainment Asset Library | SIE lists God of War press/newsroom assets, but the page also states game titles, artwork, and associated imagery are copyright/trademark material with all rights reserved. | Do not import. Press assets are not a reusable app asset license. |
| The Last of Us | Sony Interactive Entertainment Asset Library | SIE lists The Last of Us press/newsroom assets under the same all-rights-reserved copyright notice. | Do not import. |
| Ghost of Tsushima | Sony Interactive Entertainment Asset Library | SIE lists Ghost of Tsushima and Director's Cut press/newsroom assets under the same all-rights-reserved copyright notice. | Do not import. |
| Grand Theft Auto | Rockstar Games copyrighted material policy | Rockstar allows some non-commercial posting of gameplay footage, but explicitly says Take-Two can take material down and lists unauthorized ports/mods using game content as removable. | Do not import. |
| Elden Ring | Bandai Namco video policy and press assets | Bandai Namco policies found are for gameplay videos or press materials, not a license to bundle character art/sprites/models into another app. | Do not import. |
| Mario Kart | Nintendo copyright page and content guidelines | Nintendo says website content, artwork, screenshots, graphics, logos, and downloads are protected and may not be reused on other websites/publications/products without permission. | Do not import. |
| The Legend of Zelda | Nintendo copyright page and content guidelines | Same Nintendo restriction; no public reusable character asset license found. | Do not import. |
| Resident Evil | Capcom fan content guidelines and video policy | Capcom allows certain fan/derivative activity, but this is not a license to copy and bundle official game assets as Petty store characters. | Do not import. |
| Heavy Rain | Quantic Dream terms of use | Quantic Dream allows downloadable press/fan-kit content only under press/promotional or personal-use terms, excluding commercial use. | Do not import. |
| Detroit: Become Human | Quantic Dream terms of use | Same Quantic Dream downloadable-content restriction. | Do not import. |
| Uncharted | Naughty Dog / PlayStation sources | No public license found that allows bundling official Uncharted character assets into another app. | Do not import. |
| The Elder Scrolls / Skyrim | Bethesda video policy and community standards | Bethesda policy found supports fan videos using game assets, not redistributing character assets in another app. | Do not import. |
| League of Legends | Riot Legal Jibber Jabber and Riot Developer General Policies | Riot allows limited, revocable, non-transferable, non-sublicensable noncommercial community use; developer policy also says not to create games using Riot IP and points products to approved assets/policies. | Do not import without explicit Riot approval. |
| Valorant | Riot Legal Jibber Jabber and Riot Developer General Policies | Same Riot restrictions; VAL assets are for compliant Riot developer products, not an unrestricted asset license. | Do not import without explicit Riot approval. |

Notes:
- "Bientos" from the request is ambiguous. It needs the exact game title before research.
- Press kits are useful for articles, trailers, and media coverage. They should not be treated as a license to repackage characters as Petty assets unless the page explicitly grants that use.

### Battle for Wesnoth

- Official source: https://github.com/wesnoth/wesnoth
- Official copyright page: https://wiki.wesnoth.org/Wesnoth:Copyrights
- Decision: good free-culture source, but most characters are tactical unit sprites rather than desktop-pet-ready side-view companion animations. Save for a later pack if we build a top-down or portrait mode.

### Veloren

- Official source: https://gitlab.com/veloren/veloren
- Official manual: https://book.veloren.net/introduction/what-is-veloren.html
- Decision: open-source and recognizable in the free-game community, but it is voxel/3D-first rather than 2D sprite-sheet-first, so it does not fit Petty's current renderer without a separate voxel/3D pipeline.
