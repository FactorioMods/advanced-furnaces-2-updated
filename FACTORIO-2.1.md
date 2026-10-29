# Validation

Tested with Factorio 2.1.23. The functional tests cover the current furnace and loader implementation.

- **Furnaces:** all five tiers smelted with native inserter feeding. Physical fluid connections, speed modules, day/night rendering, heat effects, idle states and low power were checked.
- **Conveyors:** native item flow and rendered playback covered both custom tiers, cardinal directions, corners, splitters, underground belts and loader input/output. Bundled loaders and Miniloader Redux PRO variants transferred items at matching belt speeds.
- **Construction:** native rotation and actual robot construction covered every bundled loader tier, four rotations, horizontal/vertical mirroring and both loader modes.
- **Multiplayer:** wagon loading, quality filters, partial ammunition stacks and loader registrations were checked with a connected client, followed by server restart and client rejoin without desync.
- **Recipes and settings:** base/Space Age profiles, missing-expansion fallbacks, steel yields and additional-ore recipe safeguards were checked. Default furnace balance was compared with the previous release.
- **Localization:** all 50 bundled locales loaded in the engine. Furnace/research names, setting descriptions and ore-name substitution were checked. Translations received an independent terminology and grammar review; representative Latin, Cyrillic, CJK and right-to-left text was rendered in game.
- **Saves:** an existing save was upgraded and reloaded; compared entity and player state was preserved. Full mod-set consistency simulations also passed.

## Limits

Settings toggles were tested separately from multiplayer. Fluid connections were checked on every tier facing north and on the first tier in all cardinal directions. The save comparison did not include tier-five furnaces, stored fluids or non-normal-quality furnaces.

Complete overhaul campaigns, arbitrary modded item metadata, diagonal wagon loading, underground side-loading, circuit wire interactions and splitter filters/priorities were not exhaustively tested. Rendered animation checks used sampled playback.

Arabic, Persian and Hebrew follow the base game's display-order format and retain its right-to-left layout limitations.
