# ggwpx-starterpack

The `ggwpx-starterpack` script for FiveM provides new players with a starter pack containing items, cash, and a vehicle. Players can claim the starter pack by interacting with a designated ped.

---

## Features

- 🎁 **Starter Pack**: Items, cash, and bank money are given to the player.
- 🚗 **Vehicle Spawn**: Spawns a vehicle at predefined locations.
- 🎯 **Target System Support**: Compatible with `interact`, `qb-target`, and `ox-target`.
- 🖋️ **Discord Logging**: Logs all starter pack claims to Discord.
- 📦 **Configurable Items**: Easy customization of starter items, vehicles, and other parameters.

---

## Setup

### 1. Configuration

Edit the configuration file to match your server's needs:

```lua
Config = {}

-- Ped configuration
Config.PedCoords = vector4(-1036.28, -2734.32, 20.17, 162.71)  -- Ped spawn location
Config.PedModel = 'u_m_m_jewelsec_01'                         -- Ped model

-- Vehicle spawn locations
Config.VehicleSpawnCoords = {
    vector4(-1040.2572, -2726.4758, 19.6629, 240.6792),  -- Spawn Point 1
    vector4(-1034.8708, -2729.5725, 19.6641, 241.0679),  -- Spawn Point 2
    vector4(-1029.3840, -2732.6367, 19.6681, 240.2436),  -- Spawn Point 3
}
Config.VehicleModel = 'adder'                              -- Vehicle model
Config.SpawnWithVehicle = true                             -- Set false to not place the player inside the vehicle

-- Starter items
Config.StarterItems = {
    { item = 'water_bottle', count = 10 },
    { item = 'sandwich', count = 10 },
    { item = 'phone', count = 1 },
}

-- Money amounts
Config.CashAmount = 1000       -- Cash given to the player
Config.BankAmount = 10000      -- Bank money given to the player

-- Discord logging
Config.DiscordWebhook = 'https://discord.com/api/webhooks/...'  -- Add your webhook URL here

-- Database table
Config.ClaimTable = 'player_starterpacks'  -- Tracks claims in the database

-- Target system
Config.TargetSystem = 'interact'  -- Options: 'qb-target', 'ox-target', 'interact'

-- Inventory system
Config.InventorySystem = 'qb-inventory'  -- Options: 'qb-inventory', 'ox_inventory'
