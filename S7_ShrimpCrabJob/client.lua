local isBusy = false
local cooldowns = {}
local collectionBlips = {}

CreateThread(function()
    for _, v in pairs(Config.Blips) do
        local blip = AddBlipForCoord(v.coords)
        SetBlipSprite(blip, v.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.9)
        SetBlipColour(blip, v.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.label)
        EndTextCommandSetBlipName(blip)
    end
end)


CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        for _, v in pairs(Config.CollectionPoints) do
            local key = math.floor(v.x)
            local dist = #(pos - v)

            if dist < 100.0 then
                if not collectionBlips[key] and not cooldowns[key] then
                    local blip = AddBlipForCoord(v.x, v.y, v.z)
                    SetBlipSprite(blip, 1)
                    SetBlipDisplay(blip, 4)
                    SetBlipScale(blip, 0.4)
                    SetBlipColour(blip, 2)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Seafood Collection")
                    EndTextCommandSetBlipName(blip)
                    collectionBlips[key] = blip
                end
            else
                if collectionBlips[key] then
                    RemoveBlip(collectionBlips[key])
                    collectionBlips[key] = nil
                end
            end
        end

        Wait(1000)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        for _, v in pairs(Config.CollectionPoints) do
            local key = math.floor(v.x)
            local dist = #(pos - v)
            if dist < 5.0 and not cooldowns[key] then
                sleep = 0
DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.5, 0.5, 0.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)

                if dist < 1.2 and not isBusy then
                    lib.showTextUI('[E] Collect Seafood')
                    if IsControlJustPressed(0, 38) then
                        lib.hideTextUI()
                        collectItem(v)
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

function collectItem(pos)
    isBusy = true
    local key = math.floor(pos.x)
    cooldowns[key] = true

    if collectionBlips[key] then
        RemoveBlip(collectionBlips[key])
        collectionBlips[key] = nil
    end

    lib.progressCircle({
        duration = Config.CollectDuration,
        label = "Collecting seafood...",
        position = 'bottom',
        useWhileDead = false,
        anim = {
            dict = 'amb@world_human_gardener_plant@male@idle_a',
            clip = 'idle_b'
        },
        canCancel = false,
        disable = { move = true, car = true, mouse = false },
    })

    ClearPedTasks(PlayerPedId())
    TriggerServerEvent("shrimpCrab:collect")

    CreateThread(function()
        Wait(Config.MarkerCooldown * 1000)
        cooldowns[key] = nil
    end)

    isBusy = false
end


CreateThread(function()
    local processing = Config.ProcessingLocation
    local selling = Config.SellingLocation

    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        if #(pos - vector3(processing.x, processing.y, processing.z)) < 2.0 then
            sleep = 0
            DrawMarker(2, processing.x, processing.y, processing.z, 0.0, 0.0, 0.0,
                0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 153, 51, 100, false, true, 2, false, false, false, false)
            if #(pos - vector3(processing.x, processing.y, processing.z)) < 1.2 and not isBusy then
                lib.showTextUI('[E] Process Seafood')
                if IsControlJustPressed(0, 38) then
                    lib.hideTextUI()
                    isBusy = true
                    lib.progressCircle({
                        duration = Config.PackDuration,
                        label = "Packing seafood...",
                        position = 'bottom',
                        useWhileDead = false,
                        anim = {
                                 dict = 'mini@prostitutestalk',
                                 clip = 'street_argue_f_a'
                               },
                        canCancel = false,
                        disable = { move = true, car = true, mouse = false },
                    })
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent("shrimpCrab:process")
                    isBusy = false
                end
            end

        elseif #(pos - vector3(selling.x, selling.y, selling.z)) < 2.0 then
            sleep = 0
            DrawMarker(2, selling.x, selling.y, selling.z, 0.0, 0.0, 0.0,
                0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 128, 255, 100, false, true, 2, false, false, false, false)
            if #(pos - vector3(selling.x, selling.y, selling.z)) < 1.2 and not isBusy then
                lib.showTextUI('[E] Sell Seafood')
                if IsControlJustPressed(0, 38) then
                    lib.hideTextUI()
                    isBusy = true
                    lib.progressCircle({
                        duration = Config.SellDuration,
                        label = "Selling seafood...",
                        position = 'bottom',
                        useWhileDead = false,
                         anim = {
                                 dict = 'mini@prostitutestalk',
                                 clip = 'street_argue_f_a'
                               },
                        canCancel = false,
                        disable = { move = true, car = true, mouse = false },
                    })
                    TriggerServerEvent("shrimpCrab:sell")
                    isBusy = false
                end
            end
        end

        Wait(sleep)
    end
end)
