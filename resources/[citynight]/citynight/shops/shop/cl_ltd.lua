local servicesxx = nil
function GetServicesJob(job)
    TriggerServerCallback('GetJobServices', function(service)
        servicesxx = service
    end)
end
local blip = nil
local libreServ  = false
local Pos = {x=-48.4,y=-1757.78,z=29.42}
local Blips = {
    name = "LTD",
    sprite = 52,
    color = 83
}
local _Items = Items
local Items = {
    {
        name = "water",
        price = 3,
    },
    {
        name = "bread",
        price = 3
    }
}
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end
local function Open()
    RageUI.Visible(RMenu:Get('ltd', "libreservice"),true)
end
function no(ms)
    RageUI.Popup({message=ms})
end
local function Open1()
    no("Vous avez appelé un ~o~épicier")
    MakeCall("ltd")
end
local function EnterZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard","E",Open,"LTD")
    KeySettings:Add("controller",46,Open,"LTD")

end
local function EnterZone1()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour appeller un épicier")
    KeySettings:Add("keyboard","E",Open1,"LTD")
    KeySettings:Add("controller",46,Open1,"LTD")

end
local function ExitZone()
    KeySettings:Clear("keyboard","E","Shop")
    KeySettings:Clear("controller","E","Shop")
    Hint:RemoveAll()
end
RMenu.Add('ltd', "libreservice", RageUI.CreateMenu(nil, "Objets disponibles",10,100))
Citizen.CreateThread(function()
    Wait(400)

    blip = AddBlipForCoord(Pos.x, Pos.y, Pos.z)
    SetBlipSprite (blip, Blips.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 1.1)
    SetBlipColour (blip,  Blips.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Blips.name)
    EndTextCommandSetBlipName(blip)
    while true do
        GetServicesJob()
        while servicesxx == nil do
            Wait(1)
        end
        if tablelength(servicesxx["ltd"]) == 0 then
            if libreServ == false then
                Zone:Remove(Pos)
                Zone:Add(Pos,EnterZone,ExitZone,"ltd",2.5)
                libreServ = true
            end
        else
            if libreServ == true then
                Zone:Remove(Pos)
                Zone:Add(Pos,EnterZone1,ExitZone,"ltd",2.5)
                libreServ = false
            end
        end
        Wait(5000)
    end
end)

function MakeCall(job,msg)
    local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
    TriggerServerEvent("call:makeCall", job, {x=plyPos.x,y=plyPos.y,z=plyPos.z}, msg)
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if RageUI.Visible(RMenu:Get('ltd', "libreservice")) then
            RageUI.DrawContent({ header = false, glare = false}, function()
                for i = 1 , #Items, 1 do
                    RageUI.Button(_Items[Items[i].name].label,nil,{RightLabel=Items[i].price.."$"},true,function(_,_,Selected)
                        if Selected then
                            local canbuy = Money:CanBuy(Items[i].price)
                            local canReceive = Inventory.CanReceive(Items[i].name,1)
                            if canbuy and canReceive then
                                items = {name=Items[i].name}
                                TriggerServerEvent("inventory:AddItem", items)
                                TriggerServerEvent("money:Pay",Items[i].price)
                            end
                        end
                    end)

                end
            end, function()
            end)
        end
    end
end)
