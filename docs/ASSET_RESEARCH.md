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

### Battle for Wesnoth

- Official source: https://github.com/wesnoth/wesnoth
- Official copyright page: https://wiki.wesnoth.org/Wesnoth:Copyrights
- Decision: good free-culture source, but most characters are tactical unit sprites rather than desktop-pet-ready side-view companion animations. Save for a later pack if we build a top-down or portrait mode.

### Veloren

- Official source: https://gitlab.com/veloren/veloren
- Official manual: https://book.veloren.net/introduction/what-is-veloren.html
- Decision: open-source and recognizable in the free-game community, but it is voxel/3D-first rather than 2D sprite-sheet-first, so it does not fit Petty's current renderer without a separate voxel/3D pipeline.
