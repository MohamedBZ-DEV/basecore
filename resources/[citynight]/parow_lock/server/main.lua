
local DoorInfo	= {}

RegisterServerEvent('esx_celldoors:updateState')
AddEventHandler('esx_celldoors:updateState', function(doorID, state)


	-- make each door a table, and clean it when toggled
	DoorInfo[doorID] = {}

	-- assign information
	DoorInfo[doorID].state = state
	DoorInfo[doorID].doorID = doorID

	TriggerClientEvent('esx_celldoors:setState', -1, doorID, state)
end)

exports["citynight"]:RegisterServerCallback('esx_celldoors:getDoorInfo', function(source, cb)
	local amount = 0
	for i=1, #Config.DoorList, 1 do
		amount = amount + 1
	end

	cb(DoorInfo, amount)
end)