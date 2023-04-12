-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
local ESX = exports['es_extended']:getSharedObject()
local inventory = exports.ox_inventory
local TriggerEvent = TriggerEvent
local RegisterNetEvent = RegisterNetEvent
local CreateThread = CreateThread

local swapHooks, createHooks = {}, {}

if Config.checkForUpdates then
    lib.versionCheck("wasabirobby/wasabi_oxshops")
end


CreateThread(function()
    while ESX == nil do Wait(0) end
    for k,_ in pairs(Config.Shops) do
        TriggerEvent('esx_society:registerSociety', k, k, 'society_'..k, 'society_'..k, 'society_'..k, {type = 'public'})
    end
end) 

CreateThread(function()
	while GetResourceState('ox_inventory') ~= 'started' do Wait(1000) end
	for k,v in pairs(Config.Shops) do
		local stash = {
			id = k,
			label = v.label..' '..Strings.inventory,
			slots = 50,
			weight = 100000,
		}
		inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight)
		local items = inventory:GetInventoryItems(k, false)
		local stashItems = {}
		if items and items ~= {} then
			for _,v in pairs(items) do
				if v and v.name then
					stashItems[#stashItems + 1] = { name = v.name, metadata = v.metadata, count = v.count, price = (v.metadata.shopData.price or 0) }
				end
			end
			local x,y,z = table.unpack(v.locations.shop.coords)
			inventory:RegisterShop(k, {
				name = v.label,
				inventory = stashItems,
				locations = {
					vec3(x,y,z),
				}
			})
		end
		swapHooks[k] = inventory:registerHook('swapItems', function(payload)
			if payload.fromInventory == k then
				TriggerEvent('wasabi_oxshops:refreshShop', k)
			elseif payload.toInventory == k and tonumber(payload.fromInventory) ~= nil then
				TriggerClientEvent('wasabi_oxshops:setProductPrice', payload.fromInventory, k, payload.toSlot)
			end
		end, {})
			
		createHooks[k] = inventory:registerHook('createItem', function(payload)
		   local metadata = payload.metadata
			if metadata?.shopData then
				local price = metadata.shopData.price
				local count = payload.count
				inventory:RemoveItem(metadata.shopData.shop, payload.item.name, payload.count)
				TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..metadata.shopData.shop, function(account)
					account.addMoney(price)
				end)
			end
		end, {})
			
		k = k
	end
	
end)

RegisterNetEvent('wasabi_oxshops:refreshShop', function(shop)
	Wait(250)
	local items = inventory:GetInventoryItems(shop, false)
	local stashItems = {}
	for _, v in pairs(items) do
		if v and v.name then
			local metadata = v.metadata
			if metadata?.shopData then
				stashItems[#stashItems + 1] = { name = v.name, metadata = metadata, count = v.count, price = metadata.shopData.price }
			end
		end
	end
	inventory:RegisterShop(shop, {
		name = Config.Shops[shop].label,
		inventory = stashItems,
		locations = {
			Config.Shops[shop].locations.shop.coords,
		}
	})
end)

RegisterNetEvent('wasabi_oxshops:setData', function(shop, slot, price)
	local item = inventory:GetSlot(shop, slot)
	if not item then return end
	local metadata = item.metadata
	metadata.shopData = {
		shop = shop,
		price = price
	}
	inventory:SetMetadata(shop, slot, metadata)
	TriggerEvent('wasabi_oxshops:refreshShop', shop)
end)


AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end
	for i=1, #swapHooks do
		inventory:removeHooks(swapHooks[i])
	end
	for i=1, #createHooks do
		inventory:removeHooks(createHooks[i])
	end
  end)
