# Advanced Furnaces 2: Improved

Five electric furnace tiers with matching conveyors and loaders.

**Factorio 2.1 · Version 1.1.3**

## Fork changes

- Updated Factorio 2.1 prototypes and corrected loader collision, placement and belt-speed handling.
- Wagon transfer preserves item stack metadata and supports quality-aware whitelist and blacklist filters. Loader registrations survive save/load.
- Optional vanilla and Space Age research profiles, with fallbacks when expansion science is unavailable.
- Configurable yield for the existing direct steel recipe: five iron ore produce one steel by default.
- Optional conservative smelting of suitable ores from installed mods, including eligible alternate direct-steel paths.
- Restored furnace artwork and working glow, aligned conveyor/loader visuals, and fresh names/settings/descriptions for all 50 bundled game locales.

## Installation and settings

Requires Factorio 2.1.23+. Disable `Load-Furn-2-SpaceAgeFix` and `Load-Furn-2-2-1-SAFix` before enabling this fork. Crafting speed, energy consumption and pollution remain configurable at startup.

Wagon loading and extra ore smelting are disabled by default. Wagon transfer supports stationary cardinal layouts. Additional-ore generation preserves suitable source quantities, time and research requirements; it excludes fluid/chemical processes, random or fractional results, byproducts and special recipe restrictions. It does not provide general overhaul compatibility. Space Exploration research profiles are experimental.

See [settings and compatibility](SUPPORT.md) for profiles, safeguards and integrations.

[Mod Portal](https://mods.factorio.com/mod/advanced-furnaces-2-updated) · [Source](https://github.com/FactorioMods/advanced-furnaces-2-updated) · [Downloads](https://github.com/FactorioMods/advanced-furnaces-2-updated/releases) · [Validation](FACTORIO-2.1.md)

## Credits

Original work by fartdog and LightningMaster; progression presets adapted from rodrigoalag's MIT-licensed release. Maintained by johnmart19 / FactorioMods. [Attribution](ATTRIBUTION.md) · [MIT license](LICENSE).
