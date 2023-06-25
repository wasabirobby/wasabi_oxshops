if not Framework.QBCore() then return end

local QBCore = exports['qb-core']:GetCoreObject()

function Framework.AddMoney(acc, price)
    exports['qb-management']:AddMoney(acc, price)
end