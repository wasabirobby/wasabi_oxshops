PlayerData = {}
PlayerLoaded = false

function IsESX()
    return GetResourceState("es_extended") ~= "missing"
end

function IsQBCore()
    return GetResourceState("qb-core") ~= "missing"
end