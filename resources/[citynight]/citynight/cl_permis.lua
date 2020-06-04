local CurrentZone = nil
local _blip = nil
local currentVehicle = nil
local Permis_config = {
    ["start"] = {x=236.97,y=-1500.587,z=28.29,a=217.0},
    ["end"] =  {x=1132.13,y=259.13,z=80.86},
    price = 100
}

local function StopVehicule(reason)
	DeleteEntity(currentVehicle)
	currentVehicle = nil
	ClearAllBlipRoutes()
	RemoveBlip(_blip)

	SetEntityCoordsNoOffset(GetPlayerPed(-1), 236.97,-1500.587,29.2,false, false, false, true)
    if Money:CanBuy(Permis_config.price) then
    TriggerServerEvent("money:Pay", Permis_config.price)
	ShowNotification("~r~Vous avez échoué\n Raison : "..reason)
    end
end


local function StopVehicule2()
	DeleteEntity(currentVehicle)
	currentVehicle = nil
	ClearAllBlipRoutes()
	RemoveBlip(_blip)
	SetEntityCoordsNoOffset(GetPlayerPed(-1), 236.97,-1500.587,29.2,false, false, false, true)
	ShowNotification("~g~Vous avez réussi votre test")
	if Money:CanBuy(Permis_config.price) then
        items = {name="permis-conduire",data={points=12,uid="LS-"..math.random(111111,999999)}}
        TriggerServerEvent("inventory:AddItem", items)
        TriggerServerEvent("money:Pay", Permis_config.price)
	else
		ShowNotification("~r~Vous n'avez pas assez d'argent")
	end
end

local function startTest()
        coords = {x=225.36,y=-1521.2,z=29.14}
        vehicleFct.SpawnVehicle("tornado5",coords,235.32,function(vehicle)
            currentVehicle = vehicle
            SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
            SetVehicleDoorsLocked(vehicle,4)
        end)
        ShowNotification("Conduisez jusqu'au point.Vitesse Max : ~b~95KM")
        Wait(5)
        ShowNotification("Faite attention de pas faire d'accident.")
        _blip = AddBlipForCoord(1132.13,259.13,80.86)
        SetBlipSprite(_blip, 1)
        SetBlipDisplay(_blip, 4)
        SetBlipScale(_blip, 1.0)
        SetBlipColour(_blip, 81)
        SetBlipAsShortRange(_blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Destination")
        EndTextCommandSetBlipName(_blip)
        SetBlipRouteColour(_blip,81)
        SetBlipRoute(_blip,true)
        KeySettings:Clear("keyboard","E","permis")
        KeySettings:Clear("controller","E","permis")
        Hint:RemoveAll()
    
end
function ShowNotification(msg)
    RageUI.Popup({message=msg})
end
local function Enter(z)
    if z == "start" then
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour commencer le test ~r~(250$)")
        KeySettings:Add("keyboard","E",startTest,"permis")
        KeySettings:Add("controller",46,startTest,"permis")
        CurrentZone = z
    else
        if currentVehicle ~= nil then
            StopVehicule2()
        end
    end
end

local function Exit(z)
        KeySettings:Clear("keyboard","E","permis")
        KeySettings:Clear("controller","E","permis")
        Hint:RemoveAll()

end
local function Create()
    local Pos = Permis_config["start"]
    local blip = AddBlipForCoord(Pos.x, Pos.y, Pos.z)
    SetBlipSprite (blip, 225)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 84)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Auto-école")
    EndTextCommandSetBlipName(blip)
    Zone:Add(Pos,Enter,Exit,"start",2.5)
    Ped:Add("David","a_m_y_bevhills_01",Pos,nil)


    Zone:Add(Permis_config["end"],Enter,Exit,"end",2.5)
end

Citizen.CreateThread(function()
    Wait(25000)
    local pos = { x = -2357.33, y = 3250.93, z = 106.05 }

        Zone:Add(pos,function()         Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour reset votre position")
        KeySettings:Add("keyboard","E",function() SetEntityCoords(GetPlayerPed(-1),0.0,0.0,0.0) end,"spawn")
        KeySettings:Add("controller",46,startTest,"spawn") end,function()         KeySettings:Clear("keyboard","E","spawn")
        KeySettings:Clear("controller","E","spawn")
        Hint:RemoveAll() end,"posReset",10.5)

end)

Citizen.CreateThread(function()
	while true do	
		Wait(1000)
		if currentVehicle ~= nil then
			if GetVehicleBodyHealth(currentVehicle) ~= 1000 then
				StopVehicule("~r~Vous avez endommagé le véhicule")
			end
			if GetEntitySpeed(currentVehicle)* 3.6 > 100 then
				StopVehicule("~r~Excès de vitesse ("..GetEntitySpeed(currentVehicle)* 3.6 .."km/h)")
			end 
		end
	end
end)
Create()



