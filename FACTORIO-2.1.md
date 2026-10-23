# Factorio 2.1 notes

Tested with **Factorio 2.1.23**. Current fork version: **1.0.3**.

## Changes

- Updated recipe category lists and underground-belt neighbour lookup.
- Fixed optional loader collision masks for Miniloader compatibility.
- Fixed in-game changelog parsing; original entries are preserved in docs/UPSTREAM-CHANGELOG.txt.

## Tests

- All five tiers smelted 100 iron ore into 100 plates on powered networks.
- Outputs survived save, restart and client rejoin; the test passed again after reload.
- Default optional-loader settings loaded alongside the Miniloader fork.

Optional overhaul recipe integrations were not all tested.

Tests used private copies of saves and local host/client sessions. Raw player data and test hooks are not shipped.

The 1.0.3 patch changes changelog text and version metadata only; the feature tests above apply to the unchanged gameplay code.
