-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

Config = {}

Config.checkForUpdates = true -- Check for updates?
Config.DrawMarkers = true -- draw markers when nearby?

Config.Shops = {
    ['uwucafe'] = { -- Job name
        label = 'UwU Cafe',
        slots = 50,
        weight = 100000,
        blip = {
            enabled = true,
            coords = vec3(-583.37, -1060.80, 22.34),
            sprite = 279,
            color = 8,
            scale = 0.7,
            string = 'UwU Cafe'
        },
        bossMenu = {
            enabled = true, -- Enable boss menu?
            coords = vec3(-597.07, -1053.40, 22.34), -- Location of boss menu
            string = '[E] - Access Boss Menu', -- Text UI label string
            range = 3.0, -- Distance to allow access/prompt with text UI
        },
        locations = {
            stash = {
                string = '[E] - Access Inventory',
                coords = vec3(-588.59, -1066.42, 22.34),
                range = 3.0
            },
            shop = {
                string = '[E] - Access Shop',
                coords = vec3(-583.37, -1060.80, 22.34),
                range = 4.0
            }
        }
    }, -- Copy and paste this shop to create more
    
}
