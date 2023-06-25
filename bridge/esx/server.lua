if not Framework.ESX() then return end

local ESX = exports['es_extended']:getSharedObject()

function Framework.AddMoney(acc, price)
    TriggerEvent('esx_addonaccount:getSharedAccount', ('society_%s'):format(acc), function(account)
        account.addMoney(price)
    end)
end