


RegisterServerCallback("vehicleshop:BuyVehicle", function(source, callback,price,targetSource,vehicle)
    local _veh = json.encode(vehicle)
    local uuid = Player.GetPlayer(targetSource).uuid

    MySQL.Async.execute(
        'INSERT INTO players_vehicles (uuid,settings,plate,label) VALUES(@uuid,@settings,@plate,@label)',
        {
            ['@uuid'] = uuid,
            ['@settings'] = _veh,
            ['@plate'] = vehicle.plate,
            ['@label'] = vehicle.label,

        }
    )
    --(true)
    callback(true)
end)