-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

description 'Wasabi OX Inventory Player Owned Shops'
author 'wasabirobby#5110'
version '1.0.4'

shared_scripts {
    '@ox_lib/init.lua',
    'configuration/*.lua',
    'bridge/framework.lua'
}

client_scripts {
    'bridge/**/client.lua',
    'client/*.lua'
}

server_scripts {
    'bridge/**/server.lua',
    'server/*.lua'
}

dependencies {
    'ox_inventory'
}
