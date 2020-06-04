local isWorking = false
local data = {}
local works = 0
local function showMessageInformation(message, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end

local function ShowNotification(msg)
    RageUI.Popup({message=msg})
end

local worksP = {
    recolte = {fct = function()
        if Player.FarmLimit <= 400 then
            showMessageInformation("~b~Récolte en cours...",5500)
            Wait(5500)
        else
            showMessageInformation("~r~Vous avez atteint la limite de farm",5500)
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
        Player.FarmLimit = Player.FarmLimit + 1
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
            showMessageInformation("~g~Vente en cours...",2000)
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
                if dataAnim.lib == nil then
                    if dataAnim.scenario ~= nil then
                        TaskStartScenarioInPlace(GetPlayerPed(-1), dataAnim.scenario)
                    end
                else
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
function ResetFarm()
works = 0
Hint:RemoveAll()
isWorking = false
data = nil

end
function Job:StartRecolte(type)
    -- Permet de stopper l'action en appuyant sur E
    if IsPedInAnyVehicle(GetPlayerPed(-1)) then return ShowNotification("~r~Descendez de votre véhicule ! ") end
    if works == 0 then
        Hint:RemoveAll()
        KeySettings:Clear("keyboard","E",Job.CurrentAction)
        KeySettings:Clear("controller","E",Job.CurrentAction)
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ~r~stopper~s~ l'action")
        KeySettings:Add("keyboard","E",StopCurrentWork,Job.CurrentAction)
        --(Job.CurrentAction)
        isWorking = true
        if isWorking then
            works = 1
            -- indexation du job (si farm orga ou pas)
            if type == "Jobs" then
                data = Job.Job.work[Job.CurrentAction]
            else
                data = Orga.Job.work[Job.CurrentAction]
            end
            Player = LocalPlayer()
            CurrentAction6 = Job.CurrentAction
            Citizen.CreateThread(function()
                -- check si on a de la place
                if data ~= nil then
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
                    worksP[tostring(data.type)].fct()
                    
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
                                    TriggerServerEvent("money:Add",data.price)
                                    TriggerServerEvent("entreprise:Add",Job:Get().name,math.floor((data.price/100)*10))
                                end
                                showMessageInformation(data.add,1000)
                                Wait(400)
                                works = 0
                                Job:StartRecolte(type)

                    end
                    works = 0
                end
            end)
            
        end
    end
end



function StopCurrentWork(bool)
    isWorking = false
    showMessageInformation("~r~Vous avez arrêté votre action",4000)
    -- Sauvegarde de la limite de farm
    local Player = LocalPlayer()
    TriggerServerEvent("core:SaveLimitFarm",Player.FarmLimit)
    local ped = GetPlayerPed(-1);
    if ped then
        ClearPedTasks(ped);
    end
    -- Reset de la zone
    Hint:RemoveAll()
    ResetFarm()
    if bool == nil then
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
        KeySettings:Add("keyboard","E",JobStartAct,Job.CurrentAction)
        KeySettings:Add("controller",46,JobStartAct,Job.CurrentAction)
    end
end