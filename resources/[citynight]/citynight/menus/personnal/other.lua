---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 29/08/2019 00:08
---
Settings = setmetatable({}, Settings)
Settings.Color = {R=255,G=255,B=255}

function Settings:Load()
    TriggerServerCallback('getSettings', function(Data)
        if Data[1] ~= nil then
            if Data[1].bind ~= nil then
                self.Bind = json.decode(Data[1].bind)
            end
            if Data[1].colors ~= nil then
                self.Color = json.decode(Data[1].colors)
            end

            self.Limit = Data[1].farm_limit
            self:Format()
        end
        
    end)
end

function Settings:Format()
    for k , v in pairs(self.Bind) do
        KeySettings:Add("keyboard",k,function()
            doAnim(v.anim, nil, v.func)
        end,"bind")
    end
    RMenu:ChangeAllColor(self.Color)
    TriggerServerEvent("saveMyColor",self.Color)
    TriggerServerEvent("saveMyBind", self.Bind)
end


RegisterCommand("loadsettings", function()
    Settings:Load()
end)


RegisterNetEvent("vehicle:AddTempClé")
AddEventHandler("vehicle:AddTempClé",function(plate,label)
    veh = GetMyVehicles()

    table.insert(veh.preter,{plate=plate,label=label})
    RageUI.Popup({message="Vous avez reçu de nouvelle clé"})
    SaveMyVehicles(veh)
end)

RMenu.Add('personnal', 'actions', RageUI.CreateSubMenu(RMenu:Get('personnal', 'main'),"Actions", "Actions disponibles"))

RMenu.Add('personnal', 'actions_mykey', RageUI.CreateSubMenu(RMenu:Get('personnal', 'actions'),"Mes clés", "Clés possédées"))

-- Settings
RMenu.Add('personnal', 'settings', RageUI.CreateSubMenu(RMenu:Get('personnal', 'main'),"Paramètres", "Paramètres disponibles"))

RMenu.Add('personnal', 'settings_bindAnim', RageUI.CreateSubMenu(RMenu:Get('personnal', 'settings'),"Paramètres", "Assigner une animation"))

RMenu.Add('personnal', 'settings_map', RageUI.CreateSubMenu(RMenu:Get('personnal', 'settings'),"Paramètres", "Personnaliser la carte"))

RMenu.Add('personnal', 'settings_customColor', RageUI.CreateSubMenu(RMenu:Get('personnal', 'settings'),"Paramètres", "Personnaliser le menu"))
local listMoney = 1
local moneyLabel = {"Propre","~r~Sale"}
Citizen.CreateThread(function()
    while true do
        Wait(1)
        if RageUI.Visible(RMenu:Get('personnal', 'actions')) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                RageUI.Button("Mes clés",nil,{},true,function(_,_,Selected)
                    if Selected then
                        local s = GetMyVehicles()
                        s = s.RefreshVehicles()

                    end
                end,RMenu:Get('personnal', 'actions_mykey'))

                RageUI.List("Donner",moneyLabel,listMoney, nil,{},true,function(_,Active,Selected,Index)
                    listMoney    = Index
                    local closestPly = nil
                    if Active then
                        closestPly =  GetPlayerServerIdInDirection(5.0)
                        HoverPlayer()
                    end
                    
                    if Selected and closestPly ~= false then
                        print(closestPly)
                        local money = KeyboardInput("Montant :",nil,5200)
                        if tonumber(money) ~= nil then 
                            money = tonumber(money)
                            if Index == 1 then
                                if Money:CanBuy(money) then
                                    TriggerServerEvent("money:Pay",money )
                                    Wait(500)
                                    TriggerServerEvent("money:Add2",money,closestPly)
                                end
                            else
                                if BlackMoney:CanBuy(money) then
                                    TriggerServerEvent("black_money:Pay",money )
                                    TriggerServerEvent("black_money:Add2",money,closestPly)
                                end
                            end   
                        end
                    end
                end)
            end, function()
            end)
        end
        if RageUI.Visible(RMenu:Get('personnal', 'actions_mykey')) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                local vehicles = GetMyVehicles()
                for i = 1 , #vehicles.data, 1 do
                    if vehicles.data[i].settings ~= nil then
                        vehicles.data[i].plate =    json.decode(vehicles.data[i].settings).plate
                    end
                    RageUI.Button(vehicles.data[i].label .. " ~g~[~HUD_COLOUR_NET_PLAYER19~" .. vehicles.data[i].plate .. "~g~] "  ,nil,{},true,function(_,_,Selected)
                        if Selected then
                            if vehicles.data[i].settings ~= nil then
                                local m = true
                                RageUI.Popup({message='Voulez vous prêter vos ~b~clés?~s~\n~g~E ~s~pour accepter\n~r~L~s~ pour refuser'})
                                Citizen.CreateThread(function()
                                    Wait(5000)
                                    if m then
                                    m = false
                                    RageUI.Popup({ message = "~r~Annulé" })
                                    end
                                end)
                                Citizen.CreateThread(function()
                                    while m do
                                        Wait(1)
                                        HoverPlayer()
                                        if IsControlJustPressed(0, Keys["E"]) then
                                        player = GetPlayerServerIdInDirection(8.0)
                                            if (player ~= false) then
                                                RageUI.Popup({ message = "~g~Vous avez prêter vos clés" })
                                                TriggerServerEvent("vehicle:PreterCle",player,vehicles.data[i].plate,vehicles.data[i].label)
                                            else
                                                RageUI.Popup({ message = "~r~Aucun joueurs proche" })
                                            end
                                            m = false
                                       end
                                       if IsControlJustPressed(0, Keys["L"]) then
                                            m = false
                                            RageUI.Popup({ message = "~r~Annulé" })
                                       end
                                    end
                                end)
                            end
                        end

                    end)
                end
                if #vehicles.preter > 0 then
                    RageUI.CenterButton("~b~↓↓↓ ~s~Autres véhicules ~b~↓↓↓"  ,nil,{},true,function(_,_,Selected)

                    end)
                    for i = 1 , #vehicles.preter , 1 do
                        RageUI.Button(vehicles.preter[i].label .. " ~g~[~HUD_COLOUR_NET_PLAYER19~" .. vehicles.preter[i].plate .. "~g~] "  ,nil,{},true,function(_,_,Selected)
                            if Selected then
                            end
                        end)
                    end
                end

            end, function()
            end)
        end
    end
end)
function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end
Citizen.CreateThread(function()
    RMenu:Get('personnal', 'settings').CinemaMode = false
    RMenu:Get('personnal', 'settings').Hud = true

    RMenu:Get('personnal', 'settings_bindAnim').ArrayTouches = {"Pav 4.","Pav 5.","Pav 6.", "Pav 7.", "Pav 8." ,"Pav 9.","ALT"}

    RMenu:Get('personnal', 'settings_bindAnim').TouchesIndex = {"N4","N5","N6","N7","N8","N9","LEFTALT"}

    RMenu:Get('personnal', 'settings_bindAnim').IndexTouches = 1

    RMenu:Get('personnal', 'settings_bindAnim').ArrayCategorie = {}
    
    RMenu:Get('personnal', 'settings_bindAnim').IndexCategorie = 1

    RMenu:Get('personnal', 'settings_bindAnim').IndexAnimations = 1

    RMenu:Get('personnal', 'settings_map').ListIndex = 1
    for k,v in pairs(Animations) do
        table.insert( RMenu:Get('personnal', 'settings_bindAnim').ArrayCategorie, k )
    end
    RMenu:Get('personnal', 'settings_bindAnim').ArrayAnim = {}
    for i=1 , #Animations[RMenu:Get('personnal', 'settings_bindAnim').ArrayCategorie[1]] , 1 do
        table.insert( RMenu:Get('personnal', 'settings_bindAnim').ArrayAnim, Animations[RMenu:Get('personnal', 'settings_bindAnim').ArrayCategorie[1]][i].name)
    end


    while true do
        Wait(1)
        if RageUI.Visible(RMenu:Get('personnal', 'settings')) then
            local self = RMenu:Get('personnal', 'settings')
            local Player = LocalPlayer()
            RageUI.DrawContent({ header = true, glare = true }, function()
                RageUI.Checkbox("Mode cinéma","Permet d'activer/désactiver le mode ~o~cinéma", self.CinemaMode,{},function(Hovered,Ative,Selected,Checked)
                    self.CinemaMode = Checked
                    if Selected then
                        Player.Hud = false
                        if not Checked then
                            Player.Hud = true
                        end
                        Player.UpdateHud()
                    end
                end)
                RageUI.Checkbox("Hud","Permet d'activer/désactiver l'~o~hud", Player.Hud,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
                        Player.Hud = Checked
                        Player.UpdateHud()
                    end
                end)
                RageUI.Checkbox("Service","Permet d'activer/désactiver ~o~votre service", inService,{},function(Hovered,Ative,Selected,Checked)
                    inService = Checked
                    if Selected then
                        UpdateService()
                        RageUI.Popup({
                            message = "Vous avez activer/désactiver votre service",
                            colors = 20
                        })
                    end
                end)

                RageUI.Button("Assigner une animation","Permet d'assigner une ~o~animation ~s~à une touche",{},true,function(_,_,Selected)

                end,RMenu:Get('personnal', 'settings_bindAnim'))

                RageUI.Button("Personnaliser le menu","Permet de personnaliser les ~o~couleur ~s~du menu",{},true,function(_,_,Selected)

                end,RMenu:Get('personnal', 'settings_customColor'))

                -- RageUI.Button("Personnaliser la carte","Permet de modifier la ~o~carte ~s~à son gout",{},true,function(_,_,Selected)

                -- end,RMenu:Get('personnal', 'settings_map'))
            end, function()
            end)
        end
        if RageUI.Visible(RMenu:Get('personnal', 'settings_map')) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                local self = RMenu:Get('personnal', 'settings_map')
                local blipsLabel = {}
                for k , v in pairs(Blips.Data) do
                    table.insert( blipsLabel, k )
                end
             --   --(json.encode(blipsLabel))
                RageUI.List("Blips",blipsLabel,self.ListIndex, nil,{},true,function(_,Active,Selected,Index)
                    self.ListIndex = Index
                end)
                RageUI.Checkbox("Afficher","Permet d'activer/désactiver l'affichage du ~o~marqueur~s~ sur la carte", Blips.Data[blipsLabel[self.ListIndex]][1].isShow,{},function(_,_,Selected,Checked)
                    Blips.Data[blipsLabel[self.ListIndex]][1].isShow = Checked
                    -- TODO
                    
                end)
                local c = Blips.Data[blipsLabel[self.ListIndex]]
            end, function()

            end)
        end 
        if RageUI.Visible(RMenu:Get('personnal', 'settings_customColor')) then
            local self = RMenu:Get('personnal', 'settings_customColor')
            self.EnableMouse = true
            RageUI.DrawContent({ header = true, glare = true }, function()
                RageUI.Progress("Couleur 1 ",Settings.Color.R,255,nil,true,true,function(_,_,Selected,Color)
                    if Selected then
                        count = KeyboardInput("~b~Entrez une couleur", nil, 3)
                        count = tonumber(count)
                        if count ~= nil and count <= 255 then
                            Color = count
                        end
                    end
                    Settings.Color.R = Color
                end)
                RageUI.Progress("Couleur 2 ",Settings.Color.B,255,nil,true,true,function(_,_,Selected,Color)
                    if Selected then
                        count = KeyboardInput("~b~Entrez une couleur", nil, 3)
                        count = tonumber(count)
                        if count ~= nil and count <= 255 then
                            Color = count
                        end
                    end
                    Settings.Color.B = Color
                end)
                RageUI.Progress("Couleur 3 ",Settings.Color.G,255,nil,true,true,function(_,_,Selected,Color)
                    if Selected then
                        count = KeyboardInput("~b~Entrez une couleur", nil, 3)
                        count = tonumber(count)
                        if count ~= nil and count <= 255 then
                            Color = count
                        end
                    end
                    Settings.Color.G = Color
                end)

                RageUI.Button("Valider","Permet d'assigner l'animations sélectionné à la touche sélectionné",{ Color = {
                    BackgroundColor = { 0, 150, 0, 25 }
                } },true,function(_,_,Selected)
                    if Selected then
                        RMenu:ChangeAllColor(Settings.Color)
                        TriggerServerEvent("saveMyColor",Settings.Color)
                    end
                end)
                RMenu:Get('personnal', 'settings_customColor'):EditSpriteColor(Settings.Color)
            end, function()

            end)
        end
        if RageUI.Visible(RMenu:Get('personnal', 'settings_bindAnim')) then
            local self = RMenu:Get('personnal', 'settings_bindAnim')
            RageUI.DrawContent({ header = true, glare = true }, function()
                RageUI.List("Touche",self.ArrayTouches,self.IndexTouches, nil,{},true,function(_,_,Selected,Index)
                    self.IndexTouches = Index
                end)

                RageUI.List("Catégorie",self.ArrayCategorie,self.IndexCategorie, nil,{},true,function(_,_,Selected,Index)
                    if Index ~= self.IndexCategorie then
                        self.IndexCategorie = Index

                        self.ArrayAnim = {}

                        for i=1 , #self.ArrayCategorie[Index] , 1 do
                    
                            table.insert( self.ArrayAnim, Animations[self.ArrayCategorie[Index]][i].name)
                        end
                    end
                end)

                RageUI.List("Animations",self.ArrayAnim,self.IndexAnimations, nil,{},true,function(_,_,Selected,Index)
                    self.IndexAnimations = Index
                    if Selected then
                        local v = Animations[self.ArrayCategorie[self.IndexCategorie]][self.IndexAnimations]
                        doAnim(v.anim, nil, v.func)
                    end
                end)


                RageUI.Button("Valider","Permet d'assigner l'animations sélectionné à la touche sélectionné",{ Color = {
                    BackgroundColor = { 0, 150, 0, 25 }
                } },true,function(_,_,Selected)
                    if Selected then
                        local found = false
                        if Settings.Bind == nil then
                            Settings.Bind = {}
                        end
                        Settings.Bind[self.TouchesIndex[self.IndexTouches]] = Animations[self.ArrayCategorie[self.IndexCategorie]][self.IndexAnimations]
                        Settings:Format()

                    end
                end)
            end, function()

            end)
        end

    end
end)

DisableHud = function(bool)
	if bool == nil then
		return Player.HUDStats
	else
		if bool then
			TriggerEvent('es:setMoneyDisplay', 1.0)
		else
			TriggerEvent('es:setMoneyDisplay', 0.0)
		end
	end
end
Citizen.CreateThread(function()
    while true do
        Wait(1)
        if RMenu:Get('personnal', 'settings').CinemaMode then
            DrawRect(0.471, 0.06, 1.065, 0.13, 0, 0, 0, 255)
            DrawRect(0.503, 0.935, 1.042, 0.13, 0, 0, 0, 255)
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(8)
            HideHudComponentThisFrame(9)
            HideHudComponentThisFrame(6)
            HideHudComponentThisFrame(19)
            HideHudAndRadarThisFrame()
        end
    end
end)
