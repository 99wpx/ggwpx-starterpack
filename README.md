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

Config.PedCoords = {
    vector4(-1036.28, -2734.32, 20.17, 162.71),
    vector4(-1033.3270, -2739.6233, 20.1693, 62.6877),
    vector4(-1042.2426, -2734.9429, 20.1693, 245.4828),
}

Config.PedModel = 'u_m_m_jewelsec_01' -- Ped model

Config.ClaimCommand = "claimstarter" -- Command

-- Coordinates for the vehicle to be spawned
Config.VehicleSpawnCoords = {
    vector4(-1040.2572, -2726.4758, 19.6629, 240.6792),  -- Spawn 1
    vector4(-1034.8708, -2729.5725, 19.6641, 241.0679),  -- Spawn 2
    vector4(-1029.3840, -2732.6367, 19.6681, 240.2436),  -- Spawn 3
}

Config.VehicleModel = 'adder' -- Vehicle model
Config.FuelSystem = "cdn-fuel" -- "legacyfuel", "cdn-fuel"
Config.DefaultFuelLevel = 50 -- Level Fuel (0-100)
Config.SpawnWithVehicle = true  -- Set this to false if you don't want the player to spawn inside the vehicle

-- Items given to the player
Config.StarterItems = {
    { item = 'water_bottle', count = 10 },
    { item = 'sandwich', count = 10 },
    { item = 'phone', count = 1 },
}

-- Amount of money given
Config.CashAmount = 1000 -- Cash amount
Config.BankAmount = 10000 -- Bank amount

-- Discord logging configuration
Config.DiscordWebhook = 'https://discord.com/api/webhooks/1284349336179703828/MjHRcV_tlc5QnxK6CwxZYxzAcUg5antf6fuuINDr-2a9qNngYzCSyleXpmnuDdoqqmd5'

-- Database table
Config.ClaimTable = 'player_starterpacks' 

-- Target System
Config.TargetSystem = 'interact' -- Options: 'qb-target', 'ox-target', 'interact'

-- Inventory System
Config.InventorySystem = 'qb-inventory' -- Options: 'qb-inventory', 'ox_inventory'
