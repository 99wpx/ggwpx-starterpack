fx_version 'cerulean'
game 'gta5'

author 'GGWPx'
description 'Advanced StarterPack'
version '4.0'

client_scripts {
    'client/main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', 
    'server/*',
}

shared_scripts {
    'config.lua',
}

dependencies {
    'qb-vehiclekeys',
    'oxmysql',
}
