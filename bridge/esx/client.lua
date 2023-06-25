if not Framework.ESX() then return end

local ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    Framework.PlayerData = xPlayer
    Framework.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    table.wipe(Framework.PlayerData)
    Framework.PlayerLoaded = false
end)

RegisterNetEvent('esx:setJob', function(job)
    Framework.PlayerData.job = job
end)

function Framework.isBoss()
    return Framework.PlayerData.job.grade_name == 'boss'
end

function Framework.OpenBossMenu(job)
    TriggerEvent('esx_society:openBossMenu', job, function(data, menu)
        menu.close()
    end, {wash = false})
end


AddEventHandler('onResourceStart', function(resource)
    if cache.resource == resource then
        Wait(500)
        Framework.PlayerData = ESX.GetPlayerData()
        Framework.PlayerLoaded = true
    end
end)