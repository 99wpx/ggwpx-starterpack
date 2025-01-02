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
Config.PedCoords = vector4(-1036.28, -2734.32, 20.17, 162.71) -- Coordinates for NPC spawn
Config.PedModel = 'u_m_m_jewelsec_01' -- Ped model

-- Target System Configuration
Config.TargetSystem = 'interact'  -- 'qb-target', 'ox-target', 'interact'

-- Inventory System Configuration
Config.InventorySystem = 'qb-inventory'  -- 'qb-inventory', 'ox_inventory'

-- Vehicle Spawn Configuration
Config.VehicleSpawnCoords = {
    vector4(-1040.2572, -2726.4758, 19.6629, 240.6792),  -- Spawn Point 1
    vector4(-1034.8708, -2729.5725, 19.6641, 241.0679),  -- Spawn Point 2
    vector4(-1029.3840, -2732.6367, 19.6681, 240.2436),  -- Spawn Point 3
}

Config.VehicleModel = 'adder'  -- Vehicle model (e.g., 'adder')
Config.SpawnWithVehicle = true  -- Set to false to not spawn player in vehicle
Config.FuelSystem = "cdn-fuel"  -- Fuel system options: "legacyfuel", "cdn-fuel"
Config.DefaultFuelLevel = 50    -- Default fuel level (0-100)

-- Starter Pack Items (Items given to the player)
Config.StarterItems = {
    { item = 'water_bottle', count = 10 }, 
    { item = 'sandwich', count = 10 },      
    { item = 'phone', count = 1 },        
}

-- Monetary Configuration (Starting funds)
Config.CashAmount = 1000   -- Amount of cash given
Config.BankAmount = 10000  -- Amount of money in the bank

-- Discord Webhook for Logging
Config.DiscordWebhook = 'https://discord.com/api/webhooks/1284349336179703828/MjHRcV_tlc5QnxK6CwxZYxzAcUg5antf6fuuINDr-2a9qNngYzCSyleXpmnuDdoqqmd5'

-- Database Table for Starter Pack Claims
Config.ClaimTable = 'player_starterpacks' 

