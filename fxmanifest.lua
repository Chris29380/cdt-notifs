--[[ Manifest ]]--
fx_version   'cerulean'
use_experimental_fxv2_oal 'no'
lua54        'yes'
games        {'gta5'}

author 'cdtdevfivem'
description 'Notification system management'

dependencies {
    'cdt-lib',
}

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'shared/*.lua'
}
    
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

client_scripts {
    'client/*.lua',
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/js/script.js',
	'html/css/style.css',
    'html/img/logo.png',
}
