local save = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000) --5M
            TriggerServerEvent('handler:savePosition', EntityGetCoords(GetPlayerPed(-1)))
            save = save +1 
            if save == 10 then
                RageUI.Popup({
                    message = "✅ Position synchronisée",
                    colors = 20
                })
                save = 0
            end
    end
end)
