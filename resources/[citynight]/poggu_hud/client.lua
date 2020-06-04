
local lastJob = nil
local isAmmoboxShown = false
local PlayerData = nil
local jobName = "Citoyen"
Citizen.CreateThread(function()

  Citizen.Wait(3000)

	SendNUIMessage({
		action = 'initGUI',
		data = { whiteMode = Config.enableWhiteBackgroundMode, enableAmmo = Config.enableAmmoBox, colorInvert = Config.disableIconColorInvert }
	})
end)


RegisterNetEvent('poggu_hud:retrieveData')
AddEventHandler('poggu_hud:retrieveData', function(data)
	SendNUIMessage({
		action = 'setMoney',
		cash = data.cash,
		black_money = data.black_money,
	})
end)

function showAlert(message, time, color)
	SendNUIMessage({
		action = 'showAlert',
		message = message,
		time = time,
		color = color
	})
end

RegisterNetEvent('poggu_hud:showAlert')
AddEventHandler('poggu_hud:showAlert', function(message, time, color)
	showAlert(message, time, color)
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		TriggerServerEvent('poggu_hud:retrieveData')

		--[[
		ESX.TriggerServerCallback('poggu_hud:retrieveData', function(data)
				SendNUIMessage({
					action = 'setMoney',
					cash = data.cash,
					bank = data.bank,
					black_money = data.black_money,
					society = data.society
				})
		end)
		]]--
	end
end)
AddEventHandler("es:activateJob",function(label)
	jobName = label
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
			
			if(lastJob ~= jobName) then
				
				lastJob = jobName
				SendNUIMessage({
					action = 'setJob',
					data = jobName
				})
			end
	
	end
end)
local jobName2 = "hide"
local lastJob2 = nil
AddEventHandler("es:activateJob2",function(label)
	jobName2 = label
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		--	print(jobName2)
			if(lastJob2 ~= jobName2) then
				
				lastJob2 = jobName2
				if jobName2 == nil then
					jobName2 = "hide"
				end
				SendNUIMessage({
					action = 'setJob2',
					data = jobName2
				})
			end
	
	end
end)


Citizen.CreateThread(function()
 while true do
		Citizen.Wait(200)
		if Config.enableAmmoBox then
			local playerPed = GetPlayerPed(-1)
			local weapon, hash = GetCurrentPedWeapon(playerPed, 1)
			if(weapon) then
				isAmmoboxShown = true
				local _,ammoInClip = GetAmmoInClip(playerPed, hash)
				SendNUIMessage({
						action = 'setAmmo',
						data = ammoInClip..'/'.. GetAmmoInPedWeapon(playerPed, hash) - ammoInClip
				})
			else
				if isAmmoboxShown then
					isAmmoboxShown = false
					SendNUIMessage({
						action = 'hideAmmobox'
					})
				end
			end
		end
	end
end)

local isMenuPaused = false

function menuPaused()
	SendNUIMessage({
		action = 'disableHud',
		data = isMenuPaused
	})
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsPauseMenuActive() then
			if not isMenuPaused then
				isMenuPaused = true
				menuPaused()
			end
		elseif isMenuPaused then
			isMenuPaused = false
			menuPaused()
		end
		if IsControlJustPressed(1, 56) and GetLastInputMethod(0) then
			SendNUIMessage({
				action = 'showAdvanced'
			})
		end
	end
end)



AddEventHandler("ui:radio",function(bool)
	SendNUIMessage({
		action = 'setRadio',
		radio = bool
	})
end)

local oldState = false
AddEventHandler("ui:voice",function(bool)
	
	if bool == 0 or bool == false or bool == nil then
		bool = false
	else
		bool = true
	end
	if bool ~= oldState then
		SendNUIMessage({
			action = 'setVoice',
			voice = bool
		})
		oldState = bool
	end

end)

