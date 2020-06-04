RMenu.Add('essence',"main", RageUI.CreateMenu(nil, "Actions disponibles",10,100,"shopui_title_gasstation","shopui_title_gasstation"))

local amount = 1
local price = 0
Citizen.CreateThread(function()
    while true do
        Wait(1)
        if RageUI.Visible(RMenu:Get('essence',"main")) then
            RageUI.DrawContent({ header = true, glare = false }, function()
                
                RageUI.Progress("Essence (%)",amount,100,nil,false,true,function(_,_,Selected,Color)
                    amount = Color
                end)
                price = amount * 1.23
                RageUI.Button("Acheter",nil,{ Color = {
                    BackgroundColor = { 37, 41, 91, 25 },
                   
                }  ,RightLabel = price.."$"},true,function(_,_,Selected)
                    if Selected then
                        local canBuy = Money:CanBuy(price)
                        if canBuy then
                            TriggerServerEvent("essence:buy",amount,1.23,true)
                            TriggerServerEvent("money:Pay", math.floor(price,2) )
                            TriggerEvent("essence:hasBuying",amount)
                        end
                    end
                end)
            end, function()
            end)
        end

    end
end)
AddEventHandler("essence:OpenMenu",function(bool)

    RageUI.Visible(RMenu:Get('essence',"main"),bool)

end)
