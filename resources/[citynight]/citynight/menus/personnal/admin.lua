RMenu.Add('personnal', 'admin', RageUI.CreateSubMenu(RMenu:Get('personnal', 'main'),"Administration", "Actions disponibles"))

RMenu.Add('personnal', 'admin_plylist', RageUI.CreateSubMenu(RMenu:Get('personnal', 'admin'),"Administration", "Joueurs connectés"))
RMenu.Add('personnal', 'world', RageUI.CreateSubMenu(RMenu:Get('personnal', 'admin'),"Administration", "Actions disponibles"))

RMenu.Add('personnal', 'admin_self', RageUI.CreateSubMenu(RMenu:Get('personnal', 'admin'),"Administration", "Actions disponibles"))


RMenu.Add('personnal', 'admin_plyaction', RageUI.CreateSubMenu(RMenu:Get('personnal', 'admin_plylist'),"Administration", "Actions disponibles"))


function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
    AddTextEntry("FMMC_KEY_TIP1", TextEntry .. "")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

local function veh (vehicle)
  SetEntityAsMissionEntity(vehicle,  false,  true)
  DeleteVehicle(veh)
end
local Freeze = false
RegisterNetEvent("admin:Freeze")
AddEventHandler("admin:Freeze",function()

    FreezeEntityPosition(GetPlayerPed(-1), not Freeze)
    Freeze = not Freeze
end)
Citizen.CreateThread(function()
    while true do
        Wait(1)

        if Freeze then

            drawTxt(0.5, 0.5, .9, "Vous êtes freeze", 4, 1, nil, 180,255,0,0)
        end
    end
end)
RegisterNetEvent("admin:tp")
AddEventHandler("admin:tp",function(coords)
    SetEntityCoords(GetPlayerPed(-1),coords)
end)
Citizen.CreateThread(function()
    local CurrentPlayer = {}
    local invisible = false
    local sprint = false
    local jump = false
    while true do

        Wait(1)

        if jump then
            SetSuperJumpThisFrame(PlayerId())
        end
        if RageUI.Visible(RMenu:Get('personnal', 'admin')) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                RageUI.Button("Liste des joueurs", nil, {
                    RightLabel = "→"
                    }, true, function(_, _, _)
                end,RMenu:Get('personnal', 'admin_plylist'))
                RageUI.Button("Monde", nil, {
                    RightLabel = "→"
                    }, true, function(_, _, _)
    
                end,RMenu:Get('personnal', 'world'))

                RageUI.Button("Sois-même", nil, {
                    RightLabel = "→"
                    }, true, function(_, _, _)
    
                end,RMenu:Get('personnal', 'admin_self'))
            end, function()
            end)
        end
        if RageUI.Visible(RMenu:Get('personnal', 'admin_self')) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                RageUI.Checkbox("Invisible",nil, invisible,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
                        invisible = Checked
                        if Checked then
                            SetEntityAlpha(GetPlayerPed(-1), 0.0)
                        else
                            ResetEntityAlpha(GetPlayerPed(-1))
                        end
                    end
                end)

                RageUI.Checkbox("Super Sprint",nil, sprint,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
                        sprint = Checked
                        if Checked then
                            SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
                        else
                            SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
                        end
                    end
                end)

                RageUI.Checkbox("Super Jump",nil, jump,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
                        jump = Checked
                    end
                end)
            end, function()
            end)
        end
        if RageUI.Visible(RMenu:Get('personnal', 'admin_plyaction')) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                RageUI.Button("Spectate", nil, {
                    }, true, function(_, _, Selected)
                        if Selected then
                            TriggerEvent('esx_spectate:spectate')
                        end
                end)

                    RageUI.Button("Revive", nil, {
                        }, true, function(_, _, Selected)
                            if Selected then
                                TriggerPlayerEvent("player:Revive", CurrentPlayer.serverId)
                            end
                    end)
                
                RageUI.Button("Exclure du serveur", nil, {
                    }, true, function(_, _, Selected)
                        if Selected then
                            
                            local Reason = KeyboardInput("Raison", "", 100)
                            ShowNotification("~r~Joueur kick ("..GetPlayerName(GetPlayerFromServerId(CurrentPlayer.serverId))..")")
                            TriggerServerEvent("esx_spectate:kick",CurrentPlayer.serverId,Reason)
                            TriggerServerEvent("_chat:messageEntered", GetPlayerName(PlayerId()), {255,255,255}, "/kick" .. " " .. CurrentPlayer.serverId .. " " .. Reason)
                            
                        end
                end)
                RageUI.Button("Give argent", nil, {
                }, true, function(_, _, Selected)
                    if Selected then
                        
                        local Reason = KeyboardInput("Montant", "", 100)
                        Reason = tonumber(Reason)
                        if Reason ~= nil then
                            ShowNotification("~r~Argent give ("..GetPlayerName(GetPlayerFromServerId(CurrentPlayer.serverId))..")")
                            TriggerServerEvent("money:Add2",Reason,CurrentPlayer.serverId)
                        end
                    end
            end)
                
                -- RageUI.Button("Bannir du serveur", nil, {
                --     }, true, function(_, _, Selected)
                --         if Selected then
                --             local Reason = KeyboardInput("Raison", "", 100)
                --             TriggerServerEvent("_chat:messageEntered", GetPlayerName(PlayerId()), {255,255,255}, "/ban" .. " " .. CurrentPlayer.serverId .. " " .. Reason)
                --         end
                -- end)

                RageUI.Button("Freeze", nil, {
                    }, true, function(_, _, Selected)
                        if Selected then
                            ShowNotification("~r~Joueur Freeze ("..GetPlayerName(GetPlayerFromServerId(CurrentPlayer.serverId))..")")
                            TriggerPlayerEvent("admin:Freeze",CurrentPlayer.serverId)
                        end
                end)

                RageUI.Button("Téléporter sur vous", nil, {
                    }, true, function(_, _, Selected)
                        if Selected then
                            
                            ShowNotification("~r~Joueur TP à vous ("..GetPlayerName(GetPlayerFromServerId(CurrentPlayer.serverId))..")")
                            TriggerPlayerEvent("admin:tp", CurrentPlayer.serverId,GetEntityCoords(GetPlayerPed(-1)))
                        end
                end)

                RageUI.Button("S'y téléporter", nil, {
                    }, true, function(_, _, Selected)
                        if Selected then
                            ShowNotification("~r~TP au joueur ("..GetPlayerName(GetPlayerFromServerId(CurrentPlayer.serverId))..")")
                            ply = GetPlayerFromServerId(CurrentPlayer.serverId)
                            ped = GetPlayerPed(ply)
                            SetEntityCoords(GetPlayerPed(-1),GetEntityCoords(GetPlayerPed(-1)))
                        end
                end)

                RageUI.Button("Give Item", nil, {
                }, true, function(_, _, Selected)
                    if Selected then
                        local ItemName = KeyboardInput("Nom de l'item", "", 100)
                        local ItemNb = KeyboardInput("Nombre d'item", "", 100)  
                        for i= 1 ,ItemNb,1 do
                            item = {name=ItemName}
                            TriggerServerEvent("inventory:AddItem2",item,CurrentPlayer.serverId)
                        end
                    end
                end)
                RageUI.Button("Set Job", nil, {
                    }, true, function(_, _, Selected)
                        if Selected then
                            local NomJob = KeyboardInput("Nom du job", "", 100)
                            local Grade = KeyboardInput("Grade", "", 100)    
                            TriggerServerEvent("job:UpdateJob2",NomJob,Grade,CurrentPlayer.serverId)
                            TriggerServerEvent("esx_spectate:kick",CurrentPlayer.serverId,"Votre job est maintenant actif vous pouvez vous reconnecter")
                        end
                end)
                RageUI.Button("Set Orga", nil, {
                }, true, function(_, _, Selected)
                    if Selected then
                        local NomJob = KeyboardInput("Nom du job", "", 100)
                        local Grade = KeyboardInput("Grade", "", 100)    
                        TriggerServerEvent("job:UpdateJob4",NomJob,Grade,CurrentPlayer.serverId)
                        TriggerServerEvent("esx_spectate:kick",CurrentPlayer.serverId,"Votre organisation est maintenant actif vous pouvez vous reconnecter")
                    end
                end)
            end, function()
            end)
        end


        if RageUI.Visible(RMenu:Get('personnal', 'world')) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                RageUI.Button("Téléporter sur son marqueur", nil, {
                    }, true, function(_, _, Selected)
                    if Selected then
                        local playerPed = GetPlayerPed(-1)
                        local WaypointHandle = GetFirstBlipInfoId(8)
                        if DoesBlipExist(WaypointHandle) then
                            local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
                            --SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, coord.z, false, false, false, true)
                            SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, -199.9, false, false, false, true)

                        end
                    end
                end)

                RageUI.Button("Spawn Véhicule", nil, {
                    }, true, function(_, _, Selected)
                    if Selected then

                        local ped = GetPlayerPed(tgt)
                        local ModelName = KeyboardInput("Véhicule", "", 100)

                        if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
                            RequestModel(ModelName)
                            while not HasModelLoaded(ModelName) do
                                Citizen.Wait(0)
                            end
                                local veh = CreateVehicle(GetHashKey(ModelName), GetEntityCoords(GetPlayerPed(-1)), GetEntityHeading(GetPlayerPed(-1)), true, true)
                                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                                Wait(50)
                        else
                            ShowNotification("~r~Erreur !")
                        end
                    end

                end)
                RageUI.Button("Réparer véhicule", nil, {
                    }, true, function(_, _, Selected)
                    if Selected then
                        local veh = LocalPlayer():GetVehicle()
                        SetVehicleFixed(veh)
                    end
                end)     

                RageUI.Button("Noclip", nil, {
                    }, true, function(_, _, Selected)
                    if Selected then
                        TriggerServerEvent("_chat:messageEntered", GetPlayerName(PlayerId()), {255,255,255}, "/noclip")
                    end
                end)
            end, function()
            end)
        end

        
        if RageUI.Visible(RMenu:Get('personnal', 'admin_plylist')) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                local players = {}
    
                for i = 0, 255 do
                    if NetworkIsPlayerActive( i ) then
                        table.insert( players, i )
                        
                    end
                end
                for _, v in pairs( players ) do
                    RageUI.Button(GetPlayerServerId(v) .. " - " .. GetPlayerName(v), nil, {
                        RightLabel = "→"
                        }, true, function(_, _, Selected)
                            if Selected then
                                CurrentPlayer = {
                                    player = v,
                                    serverId = GetPlayerServerId(v)
                                }
                            end
                    end,RMenu:Get('personnal', 'admin_plyaction'))
                end
            end, function()
            end)
        end
    end
end)

if playerGroup ~= nil and (playerGroup == 'admin' or playerGroup == 'superadmin') then
AddMenuadminMenu(mainMenu)
end