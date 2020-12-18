# wario4prac: Wario Land 4 Speedrun Practice Hack

## Installation
1. [Download the release .zip.](https://github.com/mpumpu/wario4prac/releases/latest/download/wario4prac.zip)
2. Apply corresponding .bps patch using [Floating IPS](https://www.romhacking.net/utilities/1040/) (or similar).

* Use wario4prac-U.bps if using the American/European version, or wario4prac-J.bps if using the Japanese version.
* ROM has to be 8.00MB, untrimmed; resulting ROM will be smaller.
* (Use [armips](https://github.com/Kingcom/armips/releases/) if you want to compile from source.)


## Main features 
* Togglable noclip during play
* Reset current room with a button combo
* Every cutscene in the run skipped (new file intro, level entering cutscenes, all boss intro cutscenes)
* All levels & bosses always available, S-Hard always unlocked
* Unkillable (your hearts cannot drop below 1, this is to allow health management practice)
* Jewel piece chests and Keyzer spawn like the level is being played on a fresh save file
* 1HP nagging sound disabled
* Soft resets sped up significantly - the game intro and save select menu are skipped
* Boss corridors are skipped (optionally accessible)
* Extremely fast level select with most animations removed

## Controls
* Soft reset: START+SELECT+A+B
* Noclip: L to enable; when enabled: SELECT to disable, START to enable camera view out of bounds, R to move faster
* Reset current room: SELECT+DOWN normal reset, SELECT+UP reset and respawn breakable blocks*
* Change difficulty: hold SELECT after a soft reset and create a new save file
* Disable music during gameplay: hold L while entering a level
* Don't skip boss timer intro: hold L while entering a boss level
* Access unused debug room: press SELECT when Hall of Hieroglyphs is selected on the passage screen
* Don't skip boss corridor: hold SELECT while entering a boss stage
* Temporarily change language (EN/JP): press SELECT in the Music Room

*SELECT+UP respawns ALL blocks in the stage, not just the current room. It also respawns coins and hearts - meant for individual room practice in its current state. It does not respawn enemies.

## Other features 
* Allow soft reset after defeating Diva
* Cannot run out of level escape time
* Map position doesn't change after defeating bosses
* Minigames can be played for free
* Shop items are free
* Faster boss door entrance (visible if using shop weapons)
* Quick save deletion
* Quicker unpausing in boss stages (subtle, a second faster)
* Cutscenes after stages and bosses (except the final cutscene) skipped

## Credits
* coding by mpu
* special thanks to Ajarmar, ssp
