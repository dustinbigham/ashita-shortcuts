# ashita-shortcuts

Ashita v4 addon, packaged as `ashitashortcuts`, that provides fast command aliases for Final Fantasy XI clients.

This is a behavior-oriented Ashita port intended for public review. It is not currently approved for HorizonXI unless HorizonXI staff explicitly approves it. Do not use it on HorizonXI before approval.

## Install

Copy the addon folder into your Ashita install:

```txt
Ashita/addons/ashitashortcuts/ashitashortcuts.lua
```

Load it in game:

```txt
/addon load ashitashortcuts
```

Show the small in-game help:

```txt
/ashitashortcuts
```

Short help alias:

```txt
/asc
```

## Examples

```txt
/c1
/c1 me
/c1 p1
/c1 a12
/rr
/b2
/bl2
/fg2
/slp2
/rf p1
/tra
/fb
```

Target shorthands include `me`, `self`, `t`, `bt`, `ft`, `st`, `stpc`, `stnpc`, `stpt`, `stal`, `lastst`, `scan`, `r`, `pet`, `p0` through `p5`, and `a10` through `a25`.

## Scope

This addon listens for manually typed chat commands, expands known aliases, and queues the equivalent client command.

It does not:

- automate repeated actions
- claim monsters automatically
- path, follow, or move the player
- inject action packets
- read inventory or storage
- act without a user-entered command

## HorizonXI Review Notes

This repository exists so the addon can be reviewed publicly.

The addon should be treated as unapproved unless and until HorizonXI staff approves it. Users are responsible for following HorizonXI rules, including any restrictions on named monster targeting or claim-assist behavior.

## Naming

This addon is intentionally packaged as `ashitashortcuts` to distinguish it from other addons named `shortcuts`.
