local WebHook = 'WEBOOK-LINK'

RegisterServerEvent('zeusaimlog:aimlog')
AddEventHandler('zeusaimlog:aimlog', function(pedId)
    local _source = source
    local name = GetPlayerName(_source)
    local targetName = GetPlayerName(pedId)
    PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({embeds={{title="__**Zeus AIM LOG**__",description="\nPlayer Name: "..name.. "`[".._source.."]`\nIs Aiming: "..targetName.." `["..pedId.."]`",color=16711680}}}), { ['Content-Type'] = 'application/json' })
end)
