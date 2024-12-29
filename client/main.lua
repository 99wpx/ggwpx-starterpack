QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    RequestModel(GetHashKey(Config.PedModel))
    while not HasModelLoaded(GetHashKey(Config.PedModel)) do
        Wait(500)
    end

    if not HasModelLoaded(GetHashKey(Config.PedModel)) then
        print("Error: Failed to load Ped model.")
        return
    end

    local spawnedPed = CreatePed(4, GetHashKey(Config.PedModel), Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 1.0, Config.PedCoords.w, false, true)
    FreezeEntityPosition(spawnedPed, true)
    SetEntityInvincible(spawnedPed, true)
    SetBlockingOfNonTemporaryEvents(spawnedPed, true)

    if Config.TargetSystem == 'qb-target' then
        if exports['qb-target'] then
            exports['qb-target']:AddTargetEntity(spawnedPed, {
                options = {
                    {
                        type = "client",
                        event = "ggwpx-starterpack:client:claimStarterpack",
                        icon = "fas fa-box-open",
                        label = "Claim Starter Pack",
                    },
                },
                distance = 2.5
            })
        else
            print("Error: 'qb-target' is not loaded or not installed.")
        end

    elseif Config.TargetSystem == 'ox_target' then
        if exports['ox_target'] then
            exports['ox_target']:AddTargetEntity(spawnedPed, {
                {
                    name = "claimStarterpack",
                    icon = "fas fa-box-open",
                    label = "Claim Starter Pack",
                    onSelect = function()
                        TriggerEvent('ggwpx-starterpack:client:claimStarterpack')  
                    end,
                    distance = 2.5
                }
            })
        else
            print("Error: 'ox_target' is not loaded or not installed.")
        end

    elseif Config.TargetSystem == 'interact' then
        if exports['interact'] then
            exports.interact:AddEntityInteraction({
                netId = NetworkGetNetworkIdFromEntity(spawnedPed),
                name = 'claimStarterpack',  
                id = 'starterpack', 
                distance = 8.5,
                interactDst = 2.5,
                options = {
                    {
                        label = 'Claim Starter Pack',
                        action = function(entity, coords, args)
                            TriggerEvent('ggwpx-starterpack:client:claimStarterpack')
                        end,
                    },
                },
            })
        else
            print("Error: 'interact' is not loaded or not installed.")
        end
    else
        print("Error: Target system not configured or missing dependencies.")
    end
end)

RegisterNetEvent('ggwpx-starterpack:client:claimStarterpack', function()
    QBCore.Functions.TriggerCallback('ggwpx-starterpack:server:canClaim', function(canClaim)
        if canClaim then
            QBCore.Functions.Progressbar('claiming_starterpack', 'Claiming Starter Pack...', 5000, false, true, {
                disableMovement = false,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = false,
            }, {}, {}, {}, function()
                TriggerServerEvent('ggwpx-starterpack:server:giveStarterPack')
            end)
            
            local ped = PlayerPedId()
            local animDict = "anim@heists@box_carry@" 
            local animName = "idle" 
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Wait(500)
            end
            TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
            local boxProp = CreateObject(GetHashKey('hei_prop_heist_box'), 0, 0, 0, true, true, true)
            AttachEntityToEntity(boxProp, ped, GetPedBoneIndex(ped, 18905), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
            Citizen.Wait(5000) 
            ClearPedTasks(ped)
            DeleteObject(boxProp)  
        else
            QBCore.Functions.Notify('You have already claimed your starter pack.', 'error')
        end
    end)
end)

RegisterNetEvent('ggwpx-starterpack:client:spawnVehicle')
AddEventHandler('ggwpx-starterpack:client:spawnVehicle', function(citizenid)
    local vehicleModel = Config.VehicleModel
    local vehicleHash = GetHashKey(vehicleModel)
    local spawnIndex = math.random(1, #Config.VehicleSpawnCoords) 
    local coords = Config.VehicleSpawnCoords[spawnIndex] 

    RequestModel(vehicleHash)
    while not HasModelLoaded(vehicleHash) do
        Wait(500)
    end

    if not HasModelLoaded(vehicleHash) then
        print("Error: Failed to load vehicle model.")
        return
    end

    local vehicle = CreateVehicle(vehicleHash, coords.x, coords.y, coords.z, coords.w, true, false)
    if DoesEntityExist(vehicle) then
        local plate = QBCore.Functions.GetPlate(vehicle)
        SetVehicleNumberPlateText(vehicle, plate)

        if Config.FuelSystem == "legacyfuel" then
            if exports['LegacyFuel'] then
                exports['LegacyFuel']:SetFuel(vehicle, Config.DefaultFuelLevel)
            else
                print("Error: 'LegacyFuel' is not loaded or not installed.")
            end
        elseif Config.FuelSystem == "cdn-fuel" then
            if exports['cdn-fuel'] then
                exports['cdn-fuel']:SetFuel(vehicle, Config.DefaultFuelLevel)
            else
                print("Error: 'cdn-fuel' is not loaded or not installed.")
            end
        else
            print("Error: Fuel system configuration is invalid.")
        end

        if Config.SpawnWithVehicle then
            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        else
            print("Vehicle spawned, but player will not be placed inside.")
        end

        TriggerServerEvent('ggwpx-starterpack:server:giveVehicleKey', plate)
        TriggerEvent('qb-vehiclekeys:client:AddKeys', plate)
    else
        print('Error: Failed to spawn vehicle. The model may be invalid or the coordinates are incorrect.')
    end
end)
