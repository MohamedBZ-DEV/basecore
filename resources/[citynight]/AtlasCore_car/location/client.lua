local loca = 1

spawnCar = function(car)
    local car = GetHashKey(car)
    RequestModel(car)

    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(loca)
    end

    local vehicle = CreateVehicle(car, -967.21362304688, -2701.9743652344, 13.68816566, 66.825347, true, false)

    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleNumberPlateText(vehicle, "LOCATION")
end

local nezowLoca = {

    Base = { Title = "Location" },

    Data = { currentMenu = "Location" },

    Events = {

        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)

            if btn.name == "Blista" then
                Wait(loca)
                spawnCar("blista")
                ShowNotification("Vous avez louer un véhicule.~b~ Le véhicule se trouve sur votre droite")

                end
        end

    },

    Menu = {

        ["Location"] = {

            b = {

                {name = "Voiture", ask = ">", askX = true},
            }

        },

        ["voiture"] = {

            b = {

                {name = "Blista", ask = "", askX = true, Description = isosu},

            }

        }

    }

}

local location = vector3(-1017.25579, -2696.8181152344, 13.97714)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Vdist2(GetEntityCoords(PlayerPedId(), false), location) < 1.5 then
			ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour louer un ~b~Véhicule")
			if IsControlJustPressed(1,51) then
				CreateMenu(nezowLoca)
			end
		end
	end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("cs_andreas")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "cs_andreas", -1016.8623046875, -2696.1853027, 12.950758094788, 154.900711, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

ShowHelpNotification = function(msg)
		BeginTextCommandDisplayHelp('STRING')
		AddTextComponentSubstringPlayerName(msg)
		EndTextCommandDisplayHelp(0, false, true, -1)
end

ShowNotification = function(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(msg)
	DrawNotification(false, true)
end