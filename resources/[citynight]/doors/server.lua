local DoorInfo	= {}



TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) = obj end)



RegisterServerEvent('esx_doorlock:updateState')

AddEventHandler('esx_doorlock:updateState', function(doorID, state)

	local xPlayer GetPlayerFromId(source)



	if type(doorID) ~= 'number' then

		print(('esx_doorlock: %s didn\'t send a number!'):format(xPlayer.identifier))

		return

	end



	if not IsAuthorized(xPlayer.job.name, ConfigDoors.DoorList[doorID]) then

		print(('esx_doorlock: %s attempted to open a locked door!'):format(xPlayer.identifier))

		return

	end



	-- make each door a table, and clean it when toggled

	DoorInfo[doorID] = {}



	-- assign information

	DoorInfo[doorID].state = state

	DoorInfo[doorID].doorID = doorID



	TriggerClientEvent('esx_doorlock:setState', -1, doorID, state)

end)



RegisterServerCallback('esx_doorlock:getDoorInfo', function(source, cb)

	cb(DoorInfo, #DoorInfo)

end)



function IsAuthorized(jobName, doorID)

	for i=1, #doorID.authorizedJobs, 1 do

		if doorID.authorizedJobs[i] == jobName then

			return true

		end

	end



	return false

end



RegisterServerEvent('esx_doorlock:hack')

AddEventHandler('esx_doorlock:hack', function(mycb)



	local source = source

	local xPlayer = GetPlayerFromId(source)

	local xPlayers = GetPlayers()

	

	if xPlayer.getInventoryItem('keycard').count >= 1 then

	xPlayer.removeInventoryItem('keycard', 1)



		TriggerClientEvent('esx_doorlock:currentlyhacking', source)

	end

end)