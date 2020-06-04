RegisterCommand("supp", function(source, args, rawCommand)
    if IsPedInAnyVehicle(GetPlayerPed(-1), 0) then
        local pVeh = GetVehiclePedIsIn(GetPlayerPed(-1), 0)
        DeleteEntity(pVeh)
        ShowNotification("~r~Véhicule supp")
    end
end, false)

Citizen.CreateThread(function()
    local attente = 500
    while true do
        local pPed = GetPlayerPed(-1)
        if IsPedSittingInAnyVehicle(pPed) then
            local pVeh = GetVehiclePedIsIn(pPed, 0)
            local vSpeed = GetEntitySpeed(pVeh)
            if vSpeed == 0.0 then
                attente = 1
                ShowHelpNotification("Appuie sur ~INPUT_PHONE~ pour allumer/éteindre le ~y~moteur")
                if IsControlJustReleased(1, 27) then
                    if GetIsVehicleEngineRunning(pVeh) then
                        SetVehicleEngineOn(pVeh, 0, 0, 1)
                    else
                        SetVehicleEngineOn(pVeh, 1, 0, 0)
                    end
                end

                if IsControlJustReleased(1, 118) then
                    SetVehicleFixed(pVeh)
                    SetVehicleDirtLevel(pVeh, 0.0)
                    SetVehicleDeformationFixed(pVeh)
                end
            else
                attente = 500
            end
        end
        Wait(attente)
    end
end) 