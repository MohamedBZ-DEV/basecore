RegisterServerEvent("spectate:Start")
AddEventHandler("spectate:Start",function(target)
	TriggerEvent('esx_spectate:spectate', source, target)
end)

RegisterServerEvent('esx_spectate:kick')
AddEventHandler('esx_spectate:kick', function(target, msg)
	DropPlayer(target, msg)
end)
