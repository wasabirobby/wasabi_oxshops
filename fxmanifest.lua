-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Wasabi OX Inventory Player Owned Shops'
author 'wasabirobby#5110'
version '1.0.3'

shared_scripts { '@ox_lib/init.lua', 'configuration/*.lua', 'bridge/framework.lua' }

client_scripts { 
    'bridge/esx/client.lua', 
    'bridge/qb/client.lua', 
    'client/*.lua' 
}

server_scripts { 
    'bridge/esx/server.lua', 
    'bridge/qb/server.lua', 
    'server/*.lua' 
}

dependencies { 'ox_inventory' }
