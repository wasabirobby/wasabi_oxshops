-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Wasabi OX Inventory Player Owned Shops'
author 'wasabirobby#5110'
version '1.0.1'

shared_scripts { '@ox_lib/init.lua', 'configuration/*.lua' }

client_scripts { 'client/*.lua' }

server_scripts { 'server/*.lua' }

dependencies { 'ox_inventory' }
