local CurrentZone
local currentData
local works = 0
local CurrentAction
local isWorking = false
local function farmStart()
    startwork(CurrentZone)
end
local function showMessageInformation(message, duree)
    duree = duree or 500
    ClearPrints()
    
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end
local function StopCurrentWork(bool)
    isWorking = false
    showMessageInformation("~r~Vous avez arrêté votre action",4000)
    -- Sauvegarde de la limite de farm
    --TriggerServerEvent("core:SaveLimitFarm",Player.FarmLimit)
    local ped = GetPlayerPed(-1);
    if ped then
        ClearPedTasks(ped);
    end
    -- Reset de la zone
    Hint:RemoveAll()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
    KeySettings:Add("keyboard","E",startwork,CurrentAction)
    KeySettings:Add("controller",46,startwork,CurrentAction)
end

Citizen.CreateThread(function()
    Wait(6000)
    while true do
        Wait(60 * 60000)
        ShowNotification("Voici votre salaire : ~b~" .. Job:GetSalary() .."$")
        TriggerServerEvent("money:Add", Job:GetSalary())
    end
end)


local function Setup()
    for _k,v in pairs(PublicFarm) do
        for k,v in pairs(v) do
            if v.blip ~= "none" then
                        local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
                        SetBlipSprite (blip, 1)
                        SetBlipDisplay(blip, 4)
                        SetBlipScale  (blip, 0.8)
                        SetBlipColour (blip,  v.blipcolor)
                        SetBlipAsShortRange(blip, true)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(v.blipname)
                        EndTextCommandSetBlipName(blip)
                       
            end
    --     --(dump(v))
                        Zone:Add(v.Pos,function()
                            CurrentData = PublicFarm[_k][k]
                            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
                            KeySettings:Add("keyboard","E",farmStart,k)
                            KeySettings:Add("controller",46,farmStart,k)
                            CurrentZone = Type
                            CurrentAction = k
                            
                        end,function()
                            Hint:RemoveAll()
                            KeySettings:Clear("keyboard","E",k)
                            KeySettings:Clear("controller",46,k)
                            CurrentZone = nil
                            CurrentData = nil
                            CurrentAction = nil
                        end,k,v.workSize or 1.5)
                    end

    end
end


local worksP = {
    recolte = {fct = function()
        if Player.FarmLimit <= 400 then
            showMessageInformation("~b~Récolte en cours...",5500)
            Wait(5500)
        else
            showMessageInformation("~b~Vous avez atteint la limite de farm",5500)
        end
    end},
    sechage = {fct = function()
        found = false
        if Inventory:GetItemCount(data.required) <= 30 then
                ShowNotification("~r~Pas assez de ".. Items[data.required].label)
                StopCurrentWork()
                return
            else 
            found = true
        end
       if found then
        showMessageInformation("~b~Sechage en cours...",5500)
        Wait(5500)
     --   Player.FarmLimit = Player.FarmLimit + 1
       else
        ShowNotification("~r~Pas assez de ".. Items[data.required].label)
        StopCurrentWork()
        return
       end
    end},
    traitement = {fct = function()
        found = false
        if Inventory:GetItemCount(data.required) <= 0 then
                ShowNotification("~r~Pas assez de ".. Items[data.required].label)
                StopCurrentWork()
                return
            else 
            found = true
        end
       if found then
        showMessageInformation("~b~Traitement en cours...",5500)
        Wait(5500)
     --   Player.FarmLimit = Player.FarmLimit + 1
       else
        ShowNotification("~r~Pas assez de ".. Items[data.required].label)
        StopCurrentWork()
        return
       end
    end},
    vente = {fct = function()
        found = false
        if Inventory:GetItemCount(data.required) <= 0 then
            ShowNotification("~r~Pas assez de ".. Items[data.required].label)
            StopCurrentWork()
            return
        else 
            found = true
       end
       if found then
            showMessageInformation("~b~Vente en cours...",2000)
            Wait(2000)
       else
            ShowNotification("~r~Pas assez de ".. Items[data.required].label)
            StopCurrentWork()
        return
       end
    end},
}

local function animsAction(animObj)
    Citizen.CreateThread(function()
        if not playAnim then
            local playerPed = GetPlayerPed(-1);
            if DoesEntityExist(playerPed) then
                -- Ckeck if ped exist
                dataAnim = animObj

                -- Play Animation
                RequestAnimDict(dataAnim.lib)
                while not HasAnimDictLoaded(dataAnim.lib) do
                    Citizen.Wait(0)
                end
                if HasAnimDictLoaded(dataAnim.lib) then
                    local flag = 0
                    if dataAnim.loop ~= nil and dataAnim.loop then
                        flag = 1
                    elseif dataAnim.move ~= nil and dataAnim.move then
                        flag = 49
                    end

                    TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
                    playAnimation = true
                end

                -- Wait end annimation
                while true do
                    Citizen.Wait(0)
                    if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
                        playAnim = false
                        TriggerEvent('ft_animation:ClFinish')
                        break
                    end
                end
            end -- end ped exist
        end
    end)
end

function startwork(type)
    -- Permet de stopper l'action en appuyant sur E
    if works == 0 then
        Hint:RemoveAll()
        if CurrentData ~= nil then
            KeySettings:Clear("keyboard","E",CurrentAction)
            KeySettings:Clear("controller","E",CurrentAction)
            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ~r~stopper~s~ l'action")
            KeySettings:Add("keyboard","E",StopCurrentWork,CurrentAction)

            isWorking = true
            if isWorking then
                works = 1
                -- indexation du job (si farm orga ou pas)
                
                data = CurrentData
                Player = LocalPlayer()
                CurrentAction6 = CurrentAction
                
                    Citizen.CreateThread(function()
                        -- check si on a de la place
                        if data.giveitem ~= nil then
                            if Inventory.CanReceive(data.giveitem,1) then
                            else
                                StopCurrentWork()
                                return
                            end
                        end
                        -- animation
                        if data.anim ~= nil then
                            animsAction(data.anim)
                        end
                        worksP[tostring(CurrentAction)].fct()
                        
                        if isWorking then
                            if data.giveitem ~= nil then
                                item = {name=data.giveitem}
                                TriggerServerEvent("inventory:AddItem",item)
                            end
                        
                            if data.required ~= nil then
                                for k,v in pairs(Inventory.Inventory) do
                                    if k == data.required then
                                        -- supprime un objet aléatoir
                                        for i = 1 , #v,1 do
                        
                                            TriggerServerEvent("inventory:RemoveItem",v[i].id,data.required)
                                            Inventory:RemoveItemToInv(v[i].id,data.required)
                                            break
                                        end
                                        break
                                    end
                                end
                            end
                                    -- Give d'argent
                                    if data.price ~= nil then
                                        TriggerServerEvent("black_money:Add",data.price)
                                    end
                                    showMessageInformation(data.add,1000)
                                    Wait(400)
                                    works = 0
                                    startwork(type)

                        end
                        works = 0
                    end)
                
            end
        end
    end
end




Citizen.CreateThread(function()
    Setup()
end)