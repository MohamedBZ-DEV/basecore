
--faim = 55
--soif = 55
--inLoading  =false
--Citizen.CreateThread(function ()
--	while true do
--		Wait(35700)
--			Citizen.Wait(3500)
--			RemoveCalories(12.12)
--			RemoveWater(11.18)
--		
--	end
--end)

faim = 55
soif = 55
inLoading  =false
Citizen.CreateThread(function ()
	while true do
		Wait(1)
			Citizen.Wait(35000)
			RemoveCalories(0.12)
			RemoveWater(0.18)
		
	end
end)

function setfaim(calories)
	faim = calories
	TriggerServerEvent("mosrow:setfaim", faim)
end
function AddCalories(calories)
	if calories == nil then
		calories = 10
	end
	if faim == 100 then return end
	if faim + calories <= 100 then
		faim = faim + calories
	else
		faim = 100
	end
	TriggerServerEvent("mosrow:setfaim", faim)					
end

function RemoveCalories(calories)
	if faim == 0 then return end
	if faim - calories >= 0 then
		faim = faim - calories
	else
		faim = 0
	end
	if faim <= 10 and faim > 0 then
		ShowNotification("Vous avez mal au ventre \n~g~Mangez vite !")
	elseif faim < 3 then
		SetEntityHealth(GetPlayerPed(-1), 0)
	end
	TriggerServerEvent("mosrow:setfaim", faim)
end

function SetSoif(water)
	soif = water
	TriggerServerEvent("mosrow:SetSoif", soif)
end
function AddWater(water)
	if soif == 100 then return end
	if soif + water <= 100 then
		soif = soif + water
	else
		soif = 100
	end
	TriggerServerEvent("mosrow:SetSoif", soif)
end

function RemoveWater(water)
	if soif == 0 then return end
	if soif - water >= 0 then
		soif = soif - water
	else
		soif = 0
	end
	if soif <= 10 and soif > 0 then
		ShowNotification("Vous avez mal au ventre \n~g~Buvez vite")
	elseif soif < 3 then
		SetEntityHealth(GetPlayerPed(-1), 0)
	end
	TriggerServerEvent("mosrow:SetSoif", soif)
end

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		
		firstspawn = 1
	end
end)

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

RegisterNetEvent("mosrow:AddCalories")
AddEventHandler("mosrow:AddCalories", function(calories)
	AddCalories(calories)
end)

RegisterNetEvent("mosrow:AddWater")
AddEventHandler("mosrow:AddWater", function(water)
	AddWater(water)
--	print(water)
end)

RegisterNetEvent("mosrow:Death")
AddEventHandler("mosrow:Death", function()
	setfaim(50)
	SetSoif(50)
end)

local function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

Citizen.CreateThread(function()
	Wait(500)
	while true do
		Citizen.Wait(1)
		ResetScriptGfxAlign()
	--	print(soif,faim)
		TriggerEvent("updateStatus",soif,faim)
			drawRct(0.016, 0.7782, 0.1420,0.016,00, 100, 2,100) 
			drawRct(0.016, 0.7782, faim/704,0.016,00, 100, 2,200) 
			drawRct(0.016, 0.795, 0.1420,0.016,00, 109, 224,100) 
			drawRct(0.016, 0.795, soif/704,0.016,00, 109, 224,200) 
		if soif < 1 or faim < 1 then
			SetEntityHealth(GetPlayerPed(-1),0)
			setfaim(50)
			SetSoif(50)
		end
	end
end)

-- Ancienne pos status


RegisterNetEvent("status:Spawned")
AddEventHandler('status:Spawned', function(faim,soif)
	TriggerEvent("updateStatus",soif,faim)
		setfaim(faim)
	SetSoif(soif)
end)


local item = nil

RegisterNetEvent('miam:Drink')
AddEventHandler('miam:Drink', function(item,Items)

    TriggerServerEvent("removeItem",item.id,item.name)
    items = Items[item.name]
--DrinkSomething(items)
	if items.soif ~= nil then
		DrinkSomething()
	else
		EatSomething(items)
	end
end)
local prop = nil
function EatSomething(items)
    DeleteEntity(prop)
    local prop_name = items.props
    IsAnimated = true
    local playerPed = GetPlayerPed(-1)
    Citizen.CreateThread(function()
        local x,y,z = table.unpack(GetEntityCoords(playerPed))
        prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
        AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0,  true, true, false, true, 1, true)
        RequestAnimDict('mp_player_inteat@burger')
        while not HasAnimDictLoaded('mp_player_inteat@burger') do
            Wait(0)
        end
        TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
        Wait(3000)
        IsAnimated = false
        ClearPedSecondaryTask(playerPed)
        DeleteObject(prop)
    end)
    AddCalories(items.faim)
end

function DrinkSomething()
    DeleteEntity(prop)
    local prop_name = items.props
    IsAnimated = true
    local playerPed = GetPlayerPed(-1)
    Citizen.CreateThread(function()
        local x,y,z = table.unpack(GetEntityCoords(playerPed))
        prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)			
        AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.030, 0.010, -85.0, 175.0, 0.0, true, true, false, true, 1, true)
        RequestAnimDict('mp_player_intdrink')  
        while not HasAnimDictLoaded('mp_player_intdrink') do
            Wait(0)
        end
        TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle',  8.0, -8, -1, 49, 0, 0, 0, 0)
        Wait(3000)
        IsAnimated = false
        ClearPedSecondaryTask(playerPed)
        DeleteObject(prop)
    end)
    AddWater(items.soif)
end


Citizen.CreateThread(function()
	Wait(6000)
	while true do
		Wait(50000)
		TriggerServerEvent("savefood",soif,faim)
		TriggerEvent("updateStatus",soif,faim)
	end
end)