

function CreateFacture(account)
    local playerId = GetPlayerServerIdInDirection(8.0)
    if playerId ~= false then
        local _facture = {
            title = KeyboardInput("Nom de la facture","",30),
            montant = tonumber(KeyboardInput("Montant de la facture","",30)),
            playerId = playerId,
            account = account
        }

        if _facture.title ~= nil and _facture.title ~= "" and tonumber(_facture.montant) ~= nil and _facture.montant ~= 0 then
            TriggerServerEvent("facture:send",_facture)
            _facture = {}
        else
            _facture = {}
            RageUI.Popup({message="~r~Facture invalide"})
        end
    else
        RageUI.Popup({message="~r~Aucun joueur proche"})
    end
end
RegisterNetEvent("facture:paied")
AddEventHandler("facture:paied",function()
    RageUI.Popup({message="~g~Facture payé"})
end)

RegisterNetEvent("facture:get")
AddEventHandler("facture:get",function(_facture)
    RageUI.Popup({message="~g~Facture:\n~s~Titre : ~p~".._facture.title.."\n~s~Montant : ~o~".._facture.montant.."$~s~\n~g~E ~s~pour accepter"})
    local paied =false
    KeySettings:Add("keyboard","E",function() 
        local canBuy = Money:CanBuy(_facture.montant)
        if canBuy then
            TriggerServerEvent("entreprise:Add",_facture.account,_facture.montant)
            TriggerServerEvent("money:Pay",_facture.montant)
            TriggerPlayerEvent("RageUI:Popup",_facture.source,{message="La cible a bien payé la facture"})
            RageUI.Popup({message="~g~Paiement accepté"})
            paied = true
        end
    end,"facture")
    Wait(6000)
    if not paied then
        TriggerPlayerEvent("RageUI:Popup",_facture.source,{message="La cible n'a ~r~pas~s~ payé la facture"})
    end
    _facture = {}
    KeySettings:Clear("keyboard","E","facture")
end)

