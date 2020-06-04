local BasicShops = {
    {
        name = "crochetage",
        price = 50,
        data = {}
    },
    {
        name = "menottes",
        price = 250,
        data = {}
    },
    {
        name = "pinces",
        price = 250,
        data = {}
    }
}

local Illegal = setmetatable({
    {
        Pos = { x = 2675.63, y = 3499.3, z = 52.3, a = 333.66},
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = false -- Image off
        },

        Items = BasicShops
    }
},Illegal)
function Illegal:CreateShops()
    for i = 1 , #Illegal , 1 do
        v = Illegal[i]
        Zone:Add(v.Pos,self.EnterZone,self.ExitZone,i,2.5)
        Marker:Add(v.Pos,v.Marker)
        Ped:Add(v.Ped.name,v.Ped.model,v.Pos,nil)
        RMenu.Add('illegal', i, RageUI.CreateMenu(nil, "Objets illégal",10,100,v.Menus.Sprite,v.Menus.Sprite))
    end
end

local CurrentZone = nil
function Illegal.Open()
    RageUI.Visible(RMenu:Get('illegal', CurrentZone),not RageUI.Visible(RMenu:Get('illegal', CurrentZone)))
end

function Illegal.Close()

end
function Illegal.EnterZone(zone)
    local jobname = Job:Get().name
    local jobgrade = Job:Get().grade[Job.Job.gradenum].name
    local found1 = false
    if Illegal[zone].RestrictedJob == nil then
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique ~r~Illégal")
        KeySettings:Add("keyboard","E",Illegal.Open,"Illezgal")
        KeySettings:Add("controller",46,Illegal.Open,"Illezgal")
        CurrentZone = zone
    else
        for i = 1 , #Illegal[zone].RestrictedJob , 1 do
            if Illegal[zone].RestrictedJob[i] == jobname then
                found1 = true
                
                break
            end
        end
        if found1 then
            local found2 = false
            for i = 1 , #Illegal[zone].RestrictedGrade , 1 do
                if Illegal[zone].RestrictedGrade[i] == jobgrade then
                    found2 = true
                    break
                end
            end
            if found2 then
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique ~r~Illégal")
                KeySettings:Add("keyboard","E",Illegal.Open,"Illezgal")
                KeySettings:Add("controller",46,Illegal.Open,"Illezgal")
                CurrentZone = zone
            end
        end
    end

end


function Illegal.ExitZone(zone)
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        if RageUI.Visible(RMenu:Get('illegal', CurrentZone)) then
            RageUI.Visible(RMenu:Get('illegal', CurrentZone),not RageUI.Visible(RMenu:Get('illegal', CurrentZone)))
        end
        KeySettings:Clear("keyboard","E","Illezgal")
        KeySettings:Clear("controller","E","Illezgal")
        Illegal.Close()
        CurrentZone  = nil
    end
end


Illegal:CreateShops()
local currentHeader = true
Citizen.CreateThread(function()
    while true do 
        Wait(1)
        if CurrentZone ~= nil then
            if RageUI.Visible(RMenu:Get('illegal',CurrentZone)) then
                RageUI.DrawContent({ header = Illegal[CurrentZone].Menus.Enabled, glare = false}, function()
                    for i = 1 , #Illegal[CurrentZone].Items , 1 do   
                        RageUI.Button(Items[Illegal[CurrentZone].Items[i].name].label,nil,{RightLabel=Illegal[CurrentZone].Items[i].price .. "$"},true,function(_,_,Selected)
                            if Selected then
                                if not Illegal[CurrentZone].Dirty then
                                    canBuy = Money:CanBuy(Illegal[CurrentZone].Items[i].price)
                                    if canBuy then
                                        
                                        if Inventory.CanReceive(Illegal[CurrentZone].Items[i].name,1) then
                                            local m = nil
                                            if Illegal[CurrentZone].Items[i].fct ~= nil then
                                                print(Illegal[CurrentZone].Items[i].type)
                                                m = Illegal[CurrentZone].Items[i].fct()
                                                if Illegal[CurrentZone].Items[i].type == "serial" then
                                                    Illegal[CurrentZone].Items[i].data.serial = m
                                                
                                                elseif  Illegal[CurrentZone].Items[i].type == "number" then
                                                    Illegal[CurrentZone].Items[i].data.num = m   
                                                else
                                                    Illegal[CurrentZone].Items[i].data[Illegal[CurrentZone].Items[i].type] = m
                                                end
                                            end
                                            
                                            items = {name=Illegal[CurrentZone].Items[i].name,data=Illegal[CurrentZone].Items[i].data}
                                            TriggerServerEvent("inventory:AddItem", items)
                                            TriggerServerEvent("money:Pay", Illegal[CurrentZone].Items[i].price )
                                        end
                                    end
                                end
                            end
                        end)
                    end
                    if #Illegal[CurrentZone].Items == 0 then
                        RageUI.Button("Vide",nil,{},true,function(_,_,Selected)

                        end)
                    end
                end, function()
                end)
            end
        end
    end
end)
