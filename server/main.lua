QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('ggwpx-starterpack:server:giveStarterPack', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then
        print("Error: Player not found.")
        return
    end

    if Config.InventorySystem == 'qb-inventory' then
        for _, item in pairs(Config.StarterItems) do
            local itemInfo = QBCore.Shared.Items[item.item:lower()]
            if itemInfo then
                Player.Functions.AddItem(item.item, item.count)
                TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
            else
                print("Error: Item '"..item.item.."' not found in shared items.")
            end
        end
        Player.Functions.AddMoney('cash', Config.CashAmount)
        Player.Functions.AddMoney('bank', Config.BankAmount)
    elseif Config.InventorySystem == 'ox_inventory' then
        if exports['ox_inventory'] then
            for _, item in pairs(Config.StarterItems) do
                exports['ox_inventory']:AddItem(src, item.item, item.count)
                TriggerClientEvent('ox_inventory:notify', src, 'Item added', item.item, item.count)
            end
            exports['ox_inventory']:AddMoney(src, 'cash', Config.CashAmount)
            exports['ox_inventory']:AddMoney(src, 'bank', Config.BankAmount)
        else
            print("Error: 'ox_inventory' is not loaded or not installed.")
        end
    else
        print("Error: Inventory system not configured or missing dependencies.")
    end

    -- Attempt to trigger vehicle spawn, if configuration exists
    if Config.VehicleSpawn then
        TriggerClientEvent('ggwpx-starterpack:client:spawnVehicle', src, Player.PlayerData.citizenid)
    else
        print("Error: Vehicle spawn is not configured.")
    end

    -- Insert claim record into the database
    if Config.ClaimTable and Config.ClaimTable ~= '' then
        MySQL.Async.execute('INSERT INTO '..Config.ClaimTable..' (citizenid) VALUES (@citizenid)', {
            ['@citizenid'] = Player.PlayerData.citizenid
        }, function(rowsChanged)
            if rowsChanged == 0 then
                print("Error: Failed to insert claim record into database.")
            end
        end)
    else
        print("Error: ClaimTable configuration is missing or invalid.")
    end

    -- Log to Discord if webhook is configured
    if Config.DiscordWebhook and Config.DiscordWebhook ~= '' then
        TriggerEvent('ggwpx-starterpack:server:logToDiscord', Player.PlayerData.name .. " claimed their starter pack.")
    else
        print("Error: Discord webhook is not configured.")
    end
end)

RegisterNetEvent('ggwpx-starterpack:server:giveVehicleKey', function(plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then
        print("Error: Player not found.")
        return
    end

    if plate and plate ~= '' then
        TriggerEvent('qb-vehiclekeys:addKey', plate, Player.PlayerData.citizenid)
    else
        print("Error: Invalid vehicle plate.")
    end
end)

QBCore.Functions.CreateCallback('ggwpx-starterpack:server:canClaim', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        print("Error: Player not found.")
        cb(false)
        return
    end

    if Config.ClaimTable and Config.ClaimTable ~= '' then
        MySQL.Async.fetchScalar('SELECT 1 FROM '..Config.ClaimTable..' WHERE citizenid = @citizenid', {
            ['@citizenid'] = Player.PlayerData.citizenid
        }, function(result)
            cb(result == nil)
        end)
    else
        print("Error: ClaimTable configuration is missing or invalid.")
        cb(false)
    end
end)

RegisterNetEvent('ggwpx-starterpack:server:logToDiscord', function(message)
    if Config.DiscordWebhook and Config.DiscordWebhook ~= '' then
        PerformHttpRequest(Config.DiscordWebhook, function() end, 'POST', json.encode({
            username = 'Starter Pack',
            embeds = {
                {
                    color = 65280,
                    title = 'Starter Pack Claimed',
                    description = message,
                    footer = { text = os.date('%Y-%m-%d %H:%M:%S') }
                }
            },
        }), { ['Content-Type'] = 'application/json' })
    else
        print("Error: Discord webhook is not configured.")
    end
end)
