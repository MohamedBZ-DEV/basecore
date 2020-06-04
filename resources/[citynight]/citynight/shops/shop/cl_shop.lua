function GeneratePhoneNumber()
    prefix = 555
    return prefix..math.random(111111,999999)
end

local BasicShops = {
    {
        name = "tel",
        price = 130,
        data = {battery=99},
        fct = GeneratePhoneNumber,
        type = "number"
    },
--    {
--        name = "battery",
--        price = 500,
--        data = {}
--    },
    {
        name = "bread",
        price = 3,
        data = {}
    },
    {
        name = "water",
        price = 3,
        data = {}
    },
    {
        name = "biere",
        price = 15,
        data = {}
    }
}
local _identity = {}
function SetMyIdentity(id)
    _identity = id[1]
end
function GetIdentity()
    return _identity
end
local Shops = setmetatable({
    {
        Pos = { x = 124.98, y = -724.977, z = 46.086, a = 347.432},
        Blips = {
            sprite = 475,
            color = 17,
            name = "Préfecture",
        },
        Ped = {
            model = "ig_fbisuit_01",
            name = "Christian"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = false
        },

        Items = {
            {
                name = "identity",
                price = 250,
                data = {},
                 type = "identity",
                fct = GetIdentity,
               
            }
        }
    },
    {
        Pos = { x = 1134.182, y = -982.477, z = 45.416, a = 275.432},
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },

        Items = BasicShops
    },
    -- {
    --     Pos = { x = -520.75, y = -855.17, z = 29.32, a = 324.86},
    --     Blips = {
    --         sprite = 59,
    --         color = 6,
    --         name = "Ikéa",
    --     },
    --     Ped = {
    --         model = "mp_m_shopkeep_01",
    --     },
    --     Menus = {
    --         Sprite = "shopui_title_conveniencestore",
    --         Enabled = false
    --     },

    --     Items = {
    --         {
    --         name = "chaise",
    --         price = 80,
    --         data = {}
    --         },
    --         {
    --         name = "armoire",
    --         price = 135,
    --         data = {}
    --         },
    --         {
    --         name = "fauteuil",
    --         price = 90,
    --         data = {}
    --         }
    --     },
    -- },
    {
        Pos = { x = 24.376, y = -1345.558, z = 28.421, a = 267.940 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },
    {
        Pos = { x = 373.015, y = 328.332, z = 102.566, a = 257.309 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },
    {
        Pos = { x = 1164.565, y = -322.121, z = 68.205, a = 100.492 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },
    {
        Pos = { x = -1486.530, y = -377.768, z = 39.163, a = 147.669 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },
    {
        Pos = { x = -1221.568, y = -908.121, z = 11.326, a = 31.739 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },

    {
        Pos = { x = 1728.614, y = 6416.729, z = 34.037, a = 247.369 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },
    {
        Pos = { x = 1958.960, y = 3741.979, z = 31.344, a = 303.196 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },
    {
        Pos = { x = 2676.389, y = 3280.362, z = 54.241, a = 332.305 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },
    {
        Pos =  { x = -3243.99, y = 999.86, z = 11.83, a = 0.0 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },
    { 
        Pos = { x = -2966.391, y = 391.324, z = 14.043, a = 88.867 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },

    { 
        Pos =  { x = 2555.474, y = 380.909, z = 107.623, a = 355.737 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },
    { 
        Pos = { x = -1820.230, y = 794.343, z = 137.089, a = 130.327 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },
    { 
        Pos = { x = -3041.18, y = 583.85, z = 6.91, a = 16.09 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },
    { 
        Pos = { x = 549.35, y = 2669.06, z = 41.16, a = 90.0 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },
    { 
        Pos = { x = 1165.91, y = 2710.77, z = 37.16, a = 180.0 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },
    { 
        Pos = { x = -705.9, y = -913.5, z = 18.22, a = 92.47 },
        Blips = {
            sprite = 59,
            color = 43,
            name = "Magasin",
        },
        Ped = {
            model = "mp_m_shopkeep_01",
            name = "Apu"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = true
        },
        Items = BasicShops
    },
    
    { -- PLC
        Hidden = true,
        RestrictedJob = {"police"},
        RestrictedGrade = {"drh","boss"},
        Pos = { x = -2418.6, y = 3330.06, z = 31.82, a = 243.48 },
        Blips = {
            sprite = 478,
            color = 43,
            name = "Police",
        },
        Ped = {
            model = "s_m_y_marine_01",
            name = "John"
        },
        Menus = {
            Sprite = "shopui_title_conveniencestore",
            Enabled = false
        },
        Items = {
            {
                name = "mm9",
                price = 2,
                data = {},
            },
                        {
                name = "cab",
                price = 2,
                data = {},
            },
                                    {
                name = "calibre12",
                price = 2,
                data = {},
            },
            {
                name = "acp45",
                price = 2,
                data = {},
            },
            {
                name = "calibre12",
                price = 2,
                data = {},
            },
           
            {
                name = "pistol",
                price = 1200,
                data = {},
                fct = GeneratePoliceSerial,
                type =  "serial"
            },
            {
                name = "pistolcombat",
                price = 1890,
                data = {},
                fct = GeneratePoliceSerial,
                type =  "serial"
            },
            {
                name = "pistol50",
                price = 1560,
                data = {},
                fct = GeneratePoliceSerial,
                type =  "serial"
            },
            {
                name = "stungun",
                price = 500,
                data = {},
                fct = GeneratePoliceSerial,
                type =  "serial"
            },
            {
                name = "flaregun",
                price = 1000,
                data = {},
                fct = GeneratePoliceSerial,
                type =  "serial"
            },
            {
                name = "assaultsmg",
                price = 15000,
                data = {},
                fct = GeneratePoliceSerial,
                type =  "serial"
            },
            {
                name = "nightstick",
                price = 50,
                data = {},
                fct = GeneratePoliceSerial,
                type =  "serial"
            },
            {
                name = "carrabine",
                price = 25000,
                data = {},
                fct = GeneratePoliceSerial,
                type =  "serial"
            },
            {
                name = "heavysniper",
                price = 50000,
                data = {},
                fct = GeneratePoliceSerial,
                type =  "serial"
            },
            {
                name = "compactrifle",
                price = 25000,
                data = {},
                fct = GeneratePoliceSerial,
                type =  "serial"
            },
        --}

        }
    },
    { -- PLC
    Hidden = true,
    RestrictedJob = {"ltd"},
    RestrictedGrade = {"drh","boss","tresorier","employe"},
    Pos = { x = 159.1, y = -3075.11, z = 5.01, a = 267.08 },
    Blips = {
        sprite = 354,
        color = 66,
        name = "Batteries",
    },
    Ped = {
        model = "a_m_m_fatlatin_01",
        name = "Grottony"
    },
    Menus = {
        Sprite = "shopui_title_conveniencestore",
        Enabled = false
    },
    Items = {
        {
            name = "batterypack",
            price = 50,
            data = {},
        },
        {
            name = "telpack",
            price = 200,
            data = {},
        },
    }
},
},Shops)
function GeneratePoliceSerial()
    local serial = "POLICE-"
    local num = math.random(11111,99999)
    return serial..num
end
function Shops:CreateShops()
    for i = 1 , #Shops , 1 do
        v = Shops[i]
        if not v.Hidden then
            local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
            SetBlipSprite (blip, v.Blips.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, 0.8)
            SetBlipColour (blip,  v.Blips.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.Blips.name)
            EndTextCommandSetBlipName(blip)
            Blips:AddBlip(blip,"Magasin",v.Blips)
        end
        Zone:Add(v.Pos,self.EnterZone,self.ExitZone,i,2.5)
        Ped:Add(v.Ped.name,v.Ped.model,v.Pos,nil)
        RMenu.Add('shops', i, RageUI.CreateMenu(nil, "Objets disponibles",10,100,v.Menus.Sprite,v.Menus.Sprite))
    end
end

local CurrentZone = nil
function Shops.Open()
    RageUI.Visible(RMenu:Get('shops', CurrentZone),not RageUI.Visible(RMenu:Get('shops', CurrentZone)))
end

function Shops.Close()

end
function Shops.EnterZone(zone)
    local jobname = Job:Get().name
    local jobgrade = Job:Get().grade[Job.Job.gradenum].name
    local found1 = false
    if Shops[zone].RestrictedJob == nil then
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
        KeySettings:Add("keyboard","E",Shops.Open,"Shop")
        KeySettings:Add("controller",46,Shops.Open,"Shop")
        CurrentZone = zone
    else
        for i = 1 , #Shops[zone].RestrictedJob , 1 do
            if Shops[zone].RestrictedJob[i] == jobname then
                found1 = true
                
                break
            end
        end
        if found1 then
            local found2 = false
            for i = 1 , #Shops[zone].RestrictedGrade , 1 do
                if Shops[zone].RestrictedGrade[i] == jobgrade then
                    found2 = true
                    break
                end
            end
            if found2 then
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
                KeySettings:Add("keyboard","E",Shops.Open,"Shop")
                KeySettings:Add("controller",46,Shops.Open,"Shop")
                CurrentZone = zone
            end
        end
    end

end


function Shops.ExitZone(zone)
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        if RageUI.Visible(RMenu:Get('shops', CurrentZone)) then
            RageUI.Visible(RMenu:Get('shops', CurrentZone),not RageUI.Visible(RMenu:Get('shops', CurrentZone)))
        end
        KeySettings:Clear("keyboard","E","Shop")
        KeySettings:Clear("controller","E","Shop")
        Shops.Close()
        CurrentZone  = nil
    end
end


Shops:CreateShops()
local currentHeader = true
Citizen.CreateThread(function()
    while true do 
        Wait(1)
        if CurrentZone ~= nil then
            if RageUI.Visible(RMenu:Get('shops',CurrentZone)) then
                RageUI.DrawContent({ header = Shops[CurrentZone].Menus.Enabled, glare = false}, function()
                    for i = 1 , #Shops[CurrentZone].Items , 1 do   
                        RageUI.Button(Items[Shops[CurrentZone].Items[i].name].label,nil,{RightLabel=Shops[CurrentZone].Items[i].price .. "$"},true,function(_,_,Selected)
                            if Selected then
                                if not Shops[CurrentZone].Dirty then
                                    canBuy = Money:CanBuy(Shops[CurrentZone].Items[i].price)
                                    if canBuy then
                                        
                                        if Inventory.CanReceive(Shops[CurrentZone].Items[i].name,1) then
                                            local m = nil
                                            if Shops[CurrentZone].Items[i].fct ~= nil then
                                                --(Shops[CurrentZone].Items[i].type)
                                                m = Shops[CurrentZone].Items[i].fct()
                                                if Shops[CurrentZone].Items[i].type == "serial" then
                                                    Shops[CurrentZone].Items[i].data.serial = m
                                                
                                                elseif  Shops[CurrentZone].Items[i].type == "number" then
                                                    Shops[CurrentZone].Items[i].data.num = m   
                                                else
                                                    --("ods")
                                                    Shops[CurrentZone].Items[i].data[Shops[CurrentZone].Items[i].type] = m
                                                end
                                            end
                                            
                                            items = {name=Shops[CurrentZone].Items[i].name,data=Shops[CurrentZone].Items[i].data}
                                            TriggerServerEvent("inventory:AddItem", items)
                                            TriggerServerEvent("money:Pay", Shops[CurrentZone].Items[i].price )
                                        end
                                    end
                                end
                            end
                        end)
                    end
                    if #Shops[CurrentZone].Items == 0 then
                        RageUI.Button("Vide",nil,{},true,function(_,_,Selected)

                        end)
                    end
                end, function()
                end)
            end
        end
    end
end)
