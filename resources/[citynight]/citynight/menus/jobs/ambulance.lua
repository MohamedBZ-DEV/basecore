Ambulance = {}


function Ambulance.Revive()
    local count = Inventory:GetItemCount("defib")
    if count > 0 then
        local playerId = GetPlayerServerIdInDirection(5.0)
        if (playerId ~= false) then
            local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

            RequestAnimDict(lib)
            while (not HasAnimDictLoaded(lib)) do Citizen.Wait(0) end
            RequestAnimDict("mini@cpr@char_a@cpr_def")
            while (not HasAnimDictLoaded("mini@cpr@char_a@cpr_def")) do Citizen.Wait(0) end
            TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_def", "cpr_intro", 8.0, -8.0, -1, 0, 0.0, false, false, false)
            Wait(12000)
            TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
            Wait(1000)
            TriggerPlayerEvent("player:Revive",playerId)
        else
            ShowNotification("~r~Aucun joueur proche")
        end
    end
end

function Ambulance.Heal()
    local count = Inventory:GetItemCount("medikit")
    if count > 0 then
        local playerId = GetPlayerServerIdInDirection(5.0)
        if (playerId ~= false) then
            TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
            TriggerPlayerEvent("player:Heal",playerId)
            ClearPedTasksImmediately(GetPlayerPed(-1))
        else
            ShowNotification("~r~Aucun joueur proche")
        end
    end
end


RegisterNetEvent('player:Heal')
AddEventHandler('player:Heal',function()

    local PlayerPed = GetPlayerPed(-1)
    SetEntityHealth(PlayerPed,200)
end)