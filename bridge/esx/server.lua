if not IsESX() then return end

function AddMoney(acc, price)
    TriggerEvent('esx_addonaccount:getSharedAccount', ('society_%s'):format(acc), function(account)
        account.addMoney(price)
    end)
end