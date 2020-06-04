function text(content)
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(1.0,1.0)
	SetTextEntry("STRING")
	AddTextComponentString(content .. "KMH")
	DrawText(0.92, 0.9)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1),false))*2.2369

		if (IsPedInAnyVehicle(GetPlayerPed(-1), false)) then
			text(math.floor(speed*1.6))
		end
	end

end)