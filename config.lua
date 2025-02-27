Config = {}

--=========================================================
--  _______   ______ ____    __    ____  ______   ___   ___
-- /  _____| /  ____|\   \  /  \  /   / |   _  \  \  \ /  /
--|  |  __  |  |  __  \   \/    \/   /  |  |_)  |  \  V  /
--|  | |_ | |  | |_ |  \            /   |   ___/    >   <
--|  |__| | |  |__| |   \    /\    /    |  |       /  .  \
-- \______|  \______|    \__/  \__/     |__|      /__/ \__\
--=========================================================
--        JOIN DISCORD : https://discord.gg/Q6AbZgkJFq
--=========================================================

-- Pedestrian Configuration (NPC for Starter Pack Claim)
Config.PedCoords = vector4(-762.3616, -1306.4858, 5.1503, 314.2458) -- Coordinates for NPC spawn
Config.PedModel = 'u_m_m_jewelsec_01' -- Ped model

-- Target System Configuration
Config.TargetSystem = 'interact'  -- 'qb-target', 'ox-target', 'interact'

-- Inventory System Configuration
Config.InventorySystem = 'qb-inventory'  -- 'qb-inventory', 'ox_inventory'

-- Vehicle Spawn Configuration
Config.VehicleSpawnCoords = {
    vector4(-743.3543, -1311.4805, 5.0004, 43.0077),  -- Spawn Point 1
    vector4(-741.1268, -1308.8752, 5.0004, 46.8685),  -- Spawn Point 2
    vector4(-739.2194, -1306.3711, 5.0004, 47.3011),  -- Spawn Point 3
}

Config.VehicleModel = 'adder'  -- Vehicle model (e.g., 'adder')
Config.SpawnWithVehicle = true  -- Set to false to not spawn player in vehicle
Config.FuelSystem = "cdn-fuel"  -- Fuel system options: "legacyfuel", "cdn-fuel"
Config.DefaultFuelLevel = 50    -- Default fuel level (0-100)

-- Starter Pack Items (Items given to the player)
Config.StarterItems = {
    { item = 'water_bottle', count = 10 },
    { item = 'sandwich', count = 10 },
    --{ item = 'phone', count = 1 },
}

-- Monetary Configuration (Starting funds)
Config.CashAmount = 1000   -- Amount of cash given
Config.BankAmount = 10000  -- Amount of money in the bank

-- Discord Webhook for Logging
Config.DiscordWebhook = ''

-- Database Table for Starter Pack Claims
Config.ClaimTable = 'player_starterpacks'

-- Optional: Table for player_vehicles
Config.PlayerVehiclesTable = 'player_vehicles' -- Change this to match your table name
