TriggerEvent('es:addGroupCommand', 'tp', 'admin', function(source, args, _)
	local x = tonumber(args[1])
	local y = tonumber(args[2])
	local z = tonumber(args[3])
	
	if x and y and z then
		TriggerClientEvent('core:teleport', source, {
			x = x,
			y = y,
			z = z
		})
	else
		TriggerClientEvent('chatMessage', source, "Info", {255, 0, 0}, "Mauvaise coord")
	end
end, function(source, _, _)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1Info', 'Vous avez pas la permisions.' } })
end)




TriggerEvent('es:addGroupCommand', 'revive', 'admin', function(source, args, _)
	TriggerClientEvent("player:Revive",args[1])
end, function(source, _, _)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1Info', 'Vous avez pas la permisions.' } })
end)