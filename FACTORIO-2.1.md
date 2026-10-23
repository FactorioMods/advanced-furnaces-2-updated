# Factorio 2.1 compatibility and verified tests

Current release: **1.0.2**. Engine/API target: **Factorio 2.1.23**. Updated 2026-10-23.

## API and compatibility changes

- Add the transport_belt collision layer to optional loaders so default settings load alongside Miniloader internal loaders.
- Declare Factorio 2.1 compatibility.
- Use recipe category lists in recipe definitions and legacy recipe matching.
- Use underground_belt_neighbour for connected underground endpoints.
- Remove obsolete prototype fields ignored by Factorio 2.1, preserving current recipes and balance.

The audit used the installed runtime/prototype schemas and reviewed removed members, read-only writes, changed signatures, defines and named table arguments. Indirect calls and optional branches require manual review; this is not a formal proof of every execution path.

## Mod-specific checks

All five furnace-pro tiers each smelted 100 iron ore into 100 iron plates on real electric networks with a connected client. Saved output inventories survived restart/rejoin and production passed again. Default optional logistics also loaded on both host and graphical client alongside Miniloader; the loader collision-mask regression was fixed.

## Shared save and multiplayer checks

The final enabled mod set passed isolated map creation, copied-save migration, bridge-free save/reload and 3,000-tick behavior/simulation checks. Matching clean release archives also passed a real localhost host/client join, 30 seconds of simulation, server save/restart, client rejoin and another 30 seconds plus save, without a detected desync. The direct multiplayer feature assertions above are separate from this earlier shared smoke coverage.

## Scope and limits

Covers iron smelting at the installed settings and default optional-loader compatibility, not every alternate smelting recipe, loader throughput, setting multiplier or overhaul. WAN and long-duration stability were not tested.

Targeted API/interaction fixtures used temporary private hooks where needed. Those hooks, raw saves, profiles, credentials and logs are excluded from public source and release ZIPs. The current release ZIP is identified by the digest on its GitHub release asset. Runtime code and private fixtures are kept separate.
