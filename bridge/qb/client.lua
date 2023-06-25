if not Framework.QBCore() then return end

local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Framework.PlayerData = QBCore.Functions.GetPlayerData()
    Framework.PlayerLoaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    Framework.PlayerData = {}
    Framework.PlayerLoaded = false
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    Framework.PlayerData.job = JobInfo
end)


function Framework.isBoss()
    return Framework.PlayerData.job.isboss
end

function Framework.OpenBossMenu(job)
    print(json.encode(job, {indent = true}))
    TriggerEvent('qb-bossmenu:client:OpenMenu')
end


AddEventHandler('onResourceStart', function(resource)
    if cache.resource == resource then
        Wait(500)
        Framework.PlayerData = QBCore.Functions.GetPlayerData()
        Framework.PlayerLoaded = true
    end
end)