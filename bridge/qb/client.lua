if not IsQBCore() then return end

local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerLoaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    PlayerLoaded = false
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    local invokingResource = GetInvokingResource()
    if invokingResource and invokingResource ~= 'qb-core' and invokingResource ~= 'qbx-core' then return end -- Not sure if this accounts for the provide setter
    PlayerData = val
end)

function IsBoss()
    return PlayerData.job.isboss
end

function OpenBossMenu()
    TriggerEvent('qb-bossmenu:client:OpenMenu')
end

AddEventHandler('onResourceStart', function(resource)
    if cache.resource == resource then
        Wait(500)
        PlayerData = QBCore.Functions.GetPlayerData()
        PlayerLoaded = true
    end
end)