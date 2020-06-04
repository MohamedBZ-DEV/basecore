local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local IsCop			= false
local myJob = nil
AddEventHandler("myJobIs",function(label)
	myJob = label
	print(label)
	if myJob == "police" then
		isCop = true
	end
end)
Citizen.CreateThread(function()

	Citizen.Wait(5000)
	if myJob == 'police' then
		IsCop = true
	else
		AddEventHandler("myJobIs",function(label)
			myJob = label
			if myJob == "police" then
				isCop = true
			end
		end)
		TriggerEvent("getJob1",function(myJob)
		
			if myJob == "police" then
				isCop = true
			end
		end)
	end

	-- Update the door list
	exports["citynight"]:TriggerServerCallback('esx_celldoors:getDoorInfo', function(doorInfo, doorCount)
		for localID = 1, doorCount do
			if doorInfo[localID] ~= nil then
				Config.DoorList[doorInfo[localID].doorID].locked = doorInfo[localID].state
			end
		end
	end)
end)
DrawText3D = function(coords, text, size, font)
	coords = vector3(coords.x, coords.y, coords.z)

	local camCoords = GetGameplayCamCoords()
	local distance = #(coords - camCoords)

	if not size then size = 1 end
	if not font then font = 0 end

	local scale = (size / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	SetTextScale(0.0 * scale, 0.55 * scale)
	SetTextFont(font)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	SetDrawOrigin(coords, 0)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		for i=1, #Config.DoorList do
			local playerCoords = GetEntityCoords(GetPlayerPed(-1))
			local closeDoor    = GetClosestObjectOfType(Config.DoorList[i].objCoords.x, Config.DoorList[i].objCoords.y, Config.DoorList[i].objCoords.z, 1.0, GetHashKey(Config.DoorList[i].objName), false, false, false)
			local distance     = GetDistanceBetweenCoords(playerCoords, Config.DoorList[i].objCoords.x, Config.DoorList[i].objCoords.y, Config.DoorList[i].objCoords.z, true)
			
			local maxDistance = 1.25
			if Config.DoorList[i].distance then
				maxDistance = Config.DoorList[i].distance
			end
			
			if distance < maxDistance then
				local size = 1
				if Config.DoorList[i].size then
					size = Config.DoorList[i].size
				end

				local displayText = '~g~Déverouillé'
				if Config.DoorList[i].locked then
					displayText = "~r~Verrouillé "
				end

				if IsCop then
					displayText = "[E] " .. displayText
				end

				DrawText3D(Config.DoorList[i].textCoords, displayText, size)
				
				if IsControlJustReleased(0, Keys['E']) then
					if IsCop then
						if Config.DoorList[i].locked then
							FreezeEntityPosition(closeDoor, false)
							Config.DoorList[i].locked = false
						else
							FreezeEntityPosition(closeDoor, true)
							Config.DoorList[i].locked = true
						end
						TriggerServerEvent('esx_celldoors:updateState', i, Config.DoorList[i].locked) -- Broadcast new state of the door to everyone
					else
						exports["citynight"]:ShowNotification("Vous n'êtes pas policier !")
					end
				end
			else
				FreezeEntityPosition(closeDoor, Config.DoorList[i].locked)
			end
		end
	end
end)

-- Set state for a door
RegisterNetEvent('esx_celldoors:setState')
AddEventHandler('esx_celldoors:setState', function(doorID, state)
	Config.DoorList[doorID].locked = state
end)