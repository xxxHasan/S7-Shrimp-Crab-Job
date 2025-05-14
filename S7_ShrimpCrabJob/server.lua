ESX = exports["es_extended"]:getSharedObject()


local DISCORD_WEBHOOK = '' -- your webhook

local function sendDiscordLog(title, description)
    PerformHttpRequest(DISCORD_WEBHOOK, function() end, 'POST', json.encode({
        username = 'Seafood Logs',
        embeds = { {
            title = title,
            description = description,
            color = 65280
        } },
    }), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('shrimpCrab:collect', function()
    local src = source
    local item = (math.random(100) <= 60) and Config.Items.Crab or Config.Items.Shrimp
    local roll = math.random(100)
    local amount = (roll <= 60) and 1 or (roll <= 90) and 5 or 10

    exports.ox_inventory:AddItem(src, item, amount)
end)

RegisterServerEvent('shrimpCrab:process', function()
    local src = source

    local crabCount = exports.ox_inventory:Search(src, 'count', Config.Items.Crab)
    local shrimpCount = exports.ox_inventory:Search(src, 'count', Config.Items.Shrimp)

    local crabBatches = math.floor(crabCount / 5)
    local shrimpBatches = math.floor(shrimpCount / 5)

    local totalProcessed = 0

    if crabBatches > 0 then
        exports.ox_inventory:RemoveItem(src, Config.Items.Crab, crabBatches * 5)
        exports.ox_inventory:AddItem(src, Config.Items.PackedCrab, crabBatches)
        totalProcessed = totalProcessed + crabBatches
    end

    if shrimpBatches > 0 then
        exports.ox_inventory:RemoveItem(src, Config.Items.Shrimp, shrimpBatches * 5)
        exports.ox_inventory:AddItem(src, Config.Items.PackedShrimp, shrimpBatches)
        totalProcessed = totalProcessed + shrimpBatches
    end

    if totalProcessed == 0 then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Processing',
            description = 'You need at least 5 shrimp or crab.',
            type = 'error'
        })
    end
end)

RegisterServerEvent('shrimpCrab:sell', function()
    local src = source
    local packedCrab = exports.ox_inventory:Search(src, 'count', Config.Items.PackedCrab)
    local packedShrimp = exports.ox_inventory:Search(src, 'count', Config.Items.PackedShrimp)
    local total = (packedCrab * Config.Prices.PackedCrab) + (packedShrimp * Config.Prices.PackedShrimp)

    if total > 0 then
        exports.ox_inventory:RemoveItem(src, Config.Items.PackedCrab, packedCrab)
        exports.ox_inventory:RemoveItem(src, Config.Items.PackedShrimp, packedShrimp)
        exports.ox_inventory:AddItem(src, 'money', total)

        local xPlayer = ESX.GetPlayerFromId(src)
        local identifiers = GetPlayerIdentifiers(src)

        local license = "N/A"
        for _, id in pairs(identifiers) do
            if string.find(id, "license:") then
                license = id
                break
            end
        end

        sendDiscordLog("🦐 Seafood Sale Logged", "**Player:** " .. xPlayer.getName() .. "\n" ..
            "**License:** `" .. license .. "`\n" ..
            "🦀 Packed Crab: " .. packedCrab .. "\n" ..
            "🦐 Packed Shrimp: " .. packedShrimp .. "\n" ..
            "💵 **Earned:** $" .. total)

        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Seafood Sale',
            description = ('You earned $%s from seafood.'):format(total),
            type = 'success'
        })
    else
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Selling',
            description = 'No packed seafood to sell.',
            type = 'error'
        })
    end
end)
