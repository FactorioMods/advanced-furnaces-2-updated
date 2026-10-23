# Advanced Furnaces 2 SpaceAgeFix: Updated

## Factorio 2.1 compatibility and validation

Current release **1.0.2** targets Factorio **2.1.23**. See [API fixes, this mod's verified tests and coverage limits](FACTORIO-2.1.md).

Factorio 2.1 update of Advanced Furnaces 2 SpaceAgeFix. Original author: fartdog, LightningMaster. Adds 5 furnaces whose crafting speed depends on the transport-belt speed * 3. Energy consumption and pollution is appropriate. In the settings, you can increase energy consumption. РЎan work with other mods for example angelssmelting, bobplates, PY, IndustrialRevolution. fixed bad code and angelssmelting. added Bio Industries stuff. please report bugs or ideas. Language en, ru, de, fi, pt-BR.

Disable the original mod before enabling this fork. Entity, item, recipe and startup setting names are retained. Mod-private runtime state belongs to the old mod identity; per-player transient UI/distribution state is rebuilt.

Multiplayer feature checks: All five furnace-pro tiers each smelted 100 iron ore into 100 iron plates on real electric networks with a connected client. Saved output inventories survived restart/rejoin and production passed again. Default optional logistics also loaded on both host and graphical client alongside Miniloader; the loader collision-mask regression was fixed. See [methods and coverage limits](FACTORIO-2.1.md).

See [Factorio 2.1 changes and validation](FACTORIO-2.1.md) and [original credits and license](ATTRIBUTION.md).
