Config = {}
--=========================================================
--  _______   ______ ____    __    ____  ______   ___   ___ 
-- /  _____| /  ____|\   \  /  \  /   / |   _  \  \  \ /  / 
--|  |  __  |  |  __  \   \/    \/   /  |  |_)  |  \  V  /  
--|  | |_ | |  | |_ |  \            /   |   ___/    >   <   
--|  |__| | |  |__| |   \    /\    /    |  |       /  .  \  
-- \______|  \______|    \__/  \__/     |__|      /__/ \__\ 
--=========================================================
--      JOIN DISCORD : discord.gg/fsyxppyr8W6
--=========================================================

-- Coordinates for the ped used to claim the starter pack
Config.PedCoords = vector4(-1036.28, -2734.32, 20.17, 162.71) -- Adjust to desired location
Config.PedModel = 'u_m_m_jewelsec_01' -- Ped model

-- Coordinates for the vehicle to be spawned
Config.VehicleSpawnCoords = {
    vector4(-1040.2572, -2726.4758, 19.6629, 240.6792),  -- Spawn 1
    vector4(-1034.8708, -2729.5725, 19.6641, 241.0679),  -- Spawn 2
    vector4(-1029.3840, -2732.6367, 19.6681, 240.2436),  -- Spawn 3
}

Config.VehicleModel = 'adder' -- Vehicle model
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
