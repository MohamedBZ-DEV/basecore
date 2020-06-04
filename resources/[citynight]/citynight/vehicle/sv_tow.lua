RegisterServerEvent("vehicle:UnTowVehicle")
AddEventHandler("vehicle:UnTowVehicle", function(id)
    MySQL.Async.execute(
        'UPDATE players_vehicles SET pound = 0 where id = @id',
        {
            ["@id"] = id,
        }
    )
end)



MySQL.ready(function ()
	local _result = nil
	      MySQL.Async.fetchAll('SELECT * FROM players_parking', {
	                }, function(result)
	                _result = result
        end)	
        MySQL.Async.fetchAll('SELECT * FROM players_vehicles WHERE pound =0', {
        }, function(result)
        while _result == nil do 
        	Wait(1)
        end
        	for i = 1 ,#_result , 1 do
        		data = json.decode(_result[i].vehicles)
        		for t = 1 , #result , 1 do
        			local found = false
        			if data.plate == result[t].plate then
        				found = true
        			end
        			if not found then
					    MySQL.Async.execute(
					        'UPDATE players_vehicles SET pound = 1 where id = @id',
					        {
					            ["@id"] = result[t].id,

					        }
					    )
        			end
        		end
        	end
        end)
end)
