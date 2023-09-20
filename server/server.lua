-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
local swapHook, buyHook

if not IsESX() and not IsQBCore() then
	error('Framework not detected')
end

CreateThread(function()
	if IsESX() then
		for k in pairs(Config.Shops) do
			TriggerEvent('esx_society:registerSociety', k, k, 'society_' .. k, 'society_' .. k, 'society_' .. k, { type = 'public' })
		end
	end
end)

CreateThread(function()
	while GetResourceState('ox_inventory') ~= 'started' do Wait(1000) end

	for k, v in pairs(Config.Shops) do
		local stash = {
			id = k,
			label = v.label .. ' ' .. Strings.inventory,
			slots = 50,
			weight = 1000000,
		}
		exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight)
		local items = exports.ox_inventory:GetInventoryItems(k, false)
		local stashItems = {}
		if items and items ~= {} then
			for _, v2 in pairs(items) do
				if v2.metadata.shopData == nil then
					v2.metadata = { shopData = { shop = k, Config.DefaultPrice } }
					print("^1Set " .. v2.name .. " to " .. k .. " shop with default price " .. Config.DefaultPrice
						.. " because metadata was nil, do not stack new items on old items even if you put same price, put them in new slot and combine them afterwards!^0")
				end
				if v2 and v2.name then
					stashItems[#stashItems + 1] = {
						name = v2.name,
						metadata = v2.metadata,
						count = v2.count,
						price = (v2.metadata.shopData.price or 0)
					}
				end
			end

			exports.ox_inventory:RegisterShop(k, {
				name = v.label,
				inventory = stashItems,
				locations = {
					v.locations.shop.coords,
				}
			})
		end
	end

	swapHook = exports.ox_inventory:registerHook('swapItems', function(payload)
		for k in pairs(Config.Shops) do
			if payload.fromInventory == k then
				TriggerEvent('wasabi_oxshops:refreshShop', k)
			elseif payload.toInventory == k and tonumber(payload.fromInventory) then
				TriggerClientEvent('wasabi_oxshops:setProductPrice', payload.fromInventory, k, payload.toSlot)
			end
		end
	end, {})

	buyHook = exports.ox_inventory:registerHook('buyItem', function(payload)
		local metadata = payload.metadata
		if metadata?.shopData then
			exports.ox_inventory:RemoveItem(metadata.shopData.shop, payload.itemName, payload.count)
			AddMoney(metadata.shopData.shop, metadata.shopData.price * payload.count)
		end
	end, {})
end)

RegisterNetEvent('wasabi_oxshops:refreshShop', function(shop)
	Wait(250)
	local items = exports.ox_inventory:GetInventoryItems(shop, false)
	local stashItems = {}
	for _, v in pairs(items) do
		if v and v.name then
			local metadata = v.metadata
			if metadata?.shopData then
				stashItems[#stashItems + 1] = { name = v.name, metadata = metadata, count = v.count, price = metadata.shopData.price }
			end
		end
	end

	exports.ox_inventory:RegisterShop(shop, {
		name = Config.Shops[shop].label,
		inventory = stashItems,
		locations = {
			Config.Shops[shop].locations.shop.coords,
		}
	})
end)

RegisterNetEvent('wasabi_oxshops:setData', function(shop, slot, price)
	local item = exports.ox_inventory:GetSlot(shop, slot)
	if not item then return end

	local metadata = item.metadata
	metadata.shopData = {
		shop = shop,
		price = price
	}

	exports.ox_inventory:SetMetadata(shop, slot, metadata)
	TriggerEvent('wasabi_oxshops:refreshShop', shop)
end)
