local LogSent = false
local LogTimeoutLength = 3 -- Every 3 mins

Citizen.CreateThread(function()
    local lastPedAimed

    while true do
        Citizen.Wait(1000)
        local letSleep = true
        local playerPed = PlayerPedId()
        if DoesEntityExist(playerPed) then
            if Citizen.InvokeNative(0xCB690F680A3EA971, playerPed, 4) then ---- Check if the player has drawn a weapon
                letSleep = false
                local isAiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
                if isAiming and targetPed ~= lastPedAimed then
                    lastPedAimed = targetPed

                    if DoesEntityExist(targetPed) and IsEntityAPed(targetPed) then
                        if IsPedAPlayer(targetPed) then
                            local targetId = NetworkGetPlayerIndexFromPed(targetPed)

                            if targetId then
                                local pedId = GetPlayerServerId(targetId)

                                if pedId and (pedId > 0) then
                                    if not LogSent then                                     
                                        TriggerServerEvent('zeusaimlog:aimlog', pedId) ---- Report the targeted player to the server
                                        LogSent = true
                                        Citizen.SetTimeout((30000 * 2) * LogTimeoutLength, function()
                                            LogSent = false
                                        end)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        if letSleep then
            Citizen.Wait(1000)
        end
    end
end)
