if not IsQBCore() then return end

function AddMoney(acc, price)
    exports['qb-management']:AddMoney(acc, price)
end