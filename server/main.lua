QBCore = exports['qb-core']:GetCoreObject()

-- Function to register the vehicle (Adapt to your database)
local function RegisterVehicle(citizenid, plate, vehicleModel)
    if Config.PlayerVehiclesTable and Config.PlayerVehiclesTable ~= '' then
        MySQL.Async.execute("INSERT INTO " .. Config.PlayerVehiclesTable .. " (citizenid, plate, vehicle) VALUES (@citizenid, @plate, @vehicle)", {
            ['@citizenid'] = citizenid,
            ['@plate'] = plate,
            ['@vehicle'] = vehicleModel
        }, function(rowsChanged)
            if rowsChanged > 0 then
                print("Vehicle registered in database for citizenid: " .. citizenid .. " plate: " .. plate)
            else
                print("Failed to register vehicle in database for citizenid: " .. citizenid .. " plate: " .. plate)
            end
        end)
    else
        print("Config.PlayerVehiclesTable not set, skipping vehicle registration!")
    end
end

RegisterNetEvent('ggwpx-starterpack:server:giveStarterPack', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    MySQL.Async.fetchScalar('SELECT 1 FROM '..Config.ClaimTable..' WHERE citizenid = @citizenid', {
        ['@citizenid'] = Player.PlayerData.citizenid
    }, function(result)
        if result then
            QBCore.Functions.Notify(src, 'You have already claimed your starter pack!', 'error')
        else
            if Config.InventorySystem == 'qb-inventory' then
                for _, item in pairs(Config.StarterItems) do
                    local itemInfo = QBCore.Shared.Items[item.item:lower()]
                    if itemInfo then
                        Player.Functions.AddItem(item.item, item.count)
                        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
                    else
                        print('Item '..item.item..' not found in shared items.')
                    end
                end
                Player.Functions.AddMoney('cash', Config.CashAmount)
                Player.Functions.AddMoney('bank', Config.BankAmount)
            elseif Config.InventorySystem == 'ox_inventory' and exports['ox_inventory'] then
                for _, item in pairs(Config.StarterItems) do
                    exports['ox_inventory']:AddItem(src, item.item, item.count)
                    TriggerClientEvent('ox_inventory:notify', src, 'Item added', item.item, item.count)
                end
                exports['ox_inventory']:AddMoney(src, 'cash', Config.CashAmount)
                exports['ox_inventory']:AddMoney(src, 'bank', Config.BankAmount)
            else
                print("Inventory system not configured or missing dependencies.")
            end
            TriggerEvent('ggwpx-starterpack:server:logToDiscord', Player.PlayerData.name .. " claimed their starter pack");
            MySQL.Async.execute('INSERT INTO '..Config.ClaimTable..' (citizenid) VALUES (@citizenid)', {
                ['@citizenid'] = Player.PlayerData.citizenid
            })
            TriggerClientEvent('ggwpx-starterpack:client:spawnVehicle', src, Player.PlayerData.citizenid)
            QBCore.Functions.Notify(src, 'You have successfully claimed your starter pack!', 'success')
        end
    end)
end)

RegisterNetEvent('ggwpx-starterpack:server:giveVehicleKey', function(plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        print("Attempting to give vehicle key for plate: " .. plate .. " to citizenid: " .. Player.PlayerData.citizenid) -- DEBUG
        TriggerEvent('qb-vehiclekeys:addKey', plate, Player.PlayerData.citizenid) -- Pass correct citizenid
                --Register the car server-side
        RegisterVehicle(Player.PlayerData.citizenid, plate, Config.VehicleModel)  -- Register after key is given

    end
end)

QBCore.Functions.CreateCallback('ggwpx-starterpack:server:canClaim', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    MySQL.Async.fetchScalar('SELECT 1 FROM '..Config.ClaimTable..' WHERE citizenid = @citizenid', {
        ['@citizenid'] = Player.PlayerData.citizenid
    }, function(result)
        cb(result == nil)
    end)
end)

RegisterNetEvent('ggwpx-starterpack:server:logToDiscord', function(message)
    local webhook = Config.DiscordWebhook
    if webhook and webhook ~= '' then
        PerformHttpRequest(webhook, function() end, 'POST', json.encode({
            username = 'Starter Pack',
            embeds = { {
                color = 65280,
                title = 'Starter Pack Claimed',
                description = message,
                footer = { text = os.date('%Y-%m-%d %H:%M:%S') }
            } },
        }), { ['Content-Type'] = 'application/json' })
    end
end)
