# HorizonXI Approval Notes

## Current Status

This addon is packaged as `ashitashortcuts` and is not approved by HorizonXI at the time of publication.

The goal of this repository is to make the source public for HorizonXI staff review.

## Behavior Summary

- Ashita v4 Lua addon.
- Public addon name: `ashitashortcuts`.
- Load command: `/addon load ashitashortcuts`.
- Help commands: `/ashitashortcuts` and `/asc`.
- Registers one `command` event callback.
- Expands manual shortcut commands into normal client commands such as `/ma`, `/ja`, `/ws`, `/pet`, `/ra`, `/target`, and `/assist`.
- Uses `AshitaCore:GetChatManager():QueueCommand(1, command)` to send the expanded command.
- Does not inject packets.
- Does not loop, repeat, schedule, or automate actions.
- Does not scan mobs, claim mobs, or choose targets automatically.

## Policy Caveat

Players should not use this addon, or any shortcut tool, to gain an unfair claim advantage. In particular, users should follow HorizonXI staff guidance around named unclaimed monster targeting and macros.

## Review Focus

Areas likely worth staff review:

- target shorthand expansion such as `p1` to `<p1>` and `a12` to `<a12>`
- default target behavior for friendly spells
- passthrough list for built-in client, Ashita, plugin, and addon commands
- dynamic action-name resolution through Ashita resources
