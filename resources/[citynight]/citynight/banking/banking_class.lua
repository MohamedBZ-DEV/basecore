Banking = {}
local Banks = {}

Banking.GetAccount = function(name)
    if Banks[name] == nil then
        Banks[name] = Banking.CreateBanks(name)
    end
    return Banks[name]
end

Banking.GetFromUUID = function(uuid)
--(json.encode(Banks))
    for i = 1 , #Banks , 1 do
        if Banks[i].owner == uuid then
            return Banks[i]
        end
    end
end
Banking.GetFromUUID2 = function(uuid)
    for i = 1 , #Banks , 1 do
        if Banks[i].coowner == uuid then
            return Banks[i]
        end
    end
end
RegisterServerCallback('getInventoryOtherPPL', function(source, callback,target)
    local _source = target
    local identifers = GetIdentifiers(_source).steam
    local player =  Player.GetPlayer(_source)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifiers', {
        ["@identifiers"] = identifers
    }, function(result)
        MySQL.Async.fetchAll('SELECT * FROM players_inventory WHERE uuid = @uuid', {
            ["@uuid"] = result[1].uuid
        }, function(result)
            callback(result,player.money,player.black_money)
        end)
    end)
end)

function Banking.CreateBanks(name)
    local FLT = {}
    local self = FLT
    FLT.label = nil
    FLT.name = name
    FLT.owner = nil
    FLT.coowner = nil
    FLT.money = nil
    FLT.quotas = nil
    FLT.id = nil
    MySQL.Async.fetchAll(
        "SELECT * FROM banking_account WHERE iban = @name",
        {
            ["@name"] = name
        },
        function(result)
            if result[1] ~= nil then
                FLT.label = result[1].label
                FLT.owner = result[1].uuid
                FLT.coowner = result[1].coowner
                FLT.money = result[1].amount
                FLT.id = result[1].id
                FLT.quotas = result[1].todayratio
            else
                return print("Aucun compte créer à cette adresse")
            end
        end
    )
    while FLT.id == nil do
        Wait(1)
    end
    FLT.removeMoney = function(m)

        MySQL.Async.execute(
            "UPDATE banking_account SET amount=amount - @m where id=@id",
            {
                ["@id"] = FLT.id,
                ["@m"] = m,
            }
        )
    end
    FLT.addMoney = function(m)
        MySQL.Async.execute(
            "UPDATE banking_account SET amount=amount + @m where id=@id",
            {
                ["@id"] = FLT.id,
                ["@m"] = m,
            }
        )
    end

    FLT.getMoney = function(m)
        return FLT.money
    end

    return FLT
end


RegisterServerCallback(
    "getBankingAccountsPly",
    function(source, callback)

        local _source = source
        local uuid = Player.GetPlayer(_source).uuid
        local acc = {own = {}, coOwn = {}}
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_account where uuid=@uuid",
            {
                ["@uuid"] = uuid
            },
            function(result)
                acc.own = result
                MySQL.Async.fetchAll(
                    "SELECT * FROM banking_account where coowner=@uuid",
                    {
                        ["@uuid"] = uuid
                    },
                    function(result)
        
                        acc.coOwn = result
        
                        callback(acc)
                    end
                )
            end
        )


    end
)
RegisterServerCallback(
    "banksExists",
    function(source, callback,name)
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_account WHERE iban = @name",
            {
                ["@name"] = name
            },
            function(result)
                if result[1] ~= nil then
                    callback(true)
                else
                    callback(false)
                end
            end
        )
    end
)
RegisterServerCallback(
    "getAllBanks",
    function(source, callback)
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_account",
            {},
            function(result)
                callback(result)
            end
        )
    end
)


RegisterServerCallback("getAllBanks2",function(source, callback)
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_account",
            {},
            function(result)
                MySQL.Async.fetchAll(
                    "SELECT * FROM players_identity",
                    {},
                    function(_result)
                        MySQL.Async.fetchAll(
                            "SELECT * FROM banking_cards",
                            {},
                            function(dresult)
                                MySQL.Async.fetchAll(
                                    "SELECT * FROM banking_transactions",
                                    {},
                                    function(mresult)
                                        callback(result,_result,dresult,mresult)
                                    end)
                            end)

                    end)
            end)
end)
MySQL.ready(function ()
    MySQL.Async.fetchAll(
        "SELECT * FROM banking_account",
        {
            ["@uuid"] = uuid
        },
        function(result)
            for i = 1 , #result , 1 do 
                local data = json.decode(result[i].todayratio)
                if type(data) == "string" then
                    data = json.decode(data)
                end
                if type(data) == "string" then
                    data = json.decode(data)
                end
                if type(data) == "string" then
                    data = json.decode(data)
                end
                if data ~= nil then
                    data.remove = 0
                    data.deposit = 0
                    data = json.encode(data)
                    MySQL.Async.execute(
                        "UPDATE banking_account SET todayratio=@data where id=@id",
                        {
                            ["@id"] = result[i].id,
                            ["@data"] = data,
                        }
                    )
                end
            end
        end
    )
end)
RegisterServerEvent('bankingRemoveFromAccount2')
AddEventHandler('bankingRemoveFromAccount2', function(name,rem)
    local source = source
    local account = Banking.GetAccount(name)
    while account.getMoney() == nil do 
        Wait(1)
    end
    account.removeMoney(rem)
end)


RegisterServerEvent('newTransaction')
AddEventHandler('newTransaction', function(_s,dest,am,details)
    MySQL.Async.execute(
        "INSERT INTO banking_transactions (src,dest,montant,details) VALUES(@src,@dest,@montant,@details)",
           {
                ['@src']   = _s,
                ['@dest']   =dest,
                ['@montant']   = am,
                ['@details']   = details,
            }
        )
end)
local function GenerateNumber(cv)
    local result = {}
    local found = false
    MySQL.Async.fetchAll(
        "SELECT * FROM banking_cards",
        {},
        function(dresult)
            local unique = false
            local table = nil
            while not unique do
                Wait(1)
                table = math.random(1111111111111111,9999999999999999)
                result = dresult
                found = false
                for i = 1 , #result , 1 do
                    if result[i].number == table then
                        found = true
                        break
                    end
                end
                if not found then
                    unique = true
                    break
                end
                print("checking " .. table)
            end
            print(table)
            cv(table)
        end)


end
local ratios = {
    ["classic"] = {maxDeposit=5000,maxRemove=5000,deposit=0,remove=0},
    ["gold"] = {maxDeposit=50000,maxRemove=50000,deposit=0,remove=0},
    ["platinium"] = {maxDeposit=100000,maxRemove=100000,deposit=0,remove=0},
    ["blackcard"] = {maxDeposit=500000,maxRemove=500000,deposit=0,remove=0},
}
RegisterServerEvent("newCard")
AddEventHandler("newCard",function(tab,id,type)
    local number = nil
    GenerateNumber(function(t)
        print(t)
        number = t
    end)
    while number == nil do
        Wait(1)
    end
    MySQL.Async.execute(
        "INSERT INTO banking_cards (type,uuid,account,code,number,current_ratio) VALUES(@type,@uuid,@account,@code,@number,@current_ratio)",
           {
                ['@type']   = type,
                ['@uuid']   = tab.uuid,
                ['@account']   = id,
                ['@code']   = tab.code,
                ['@number']   =number,
                ['@current_ratio'] = json.encode(ratios[type])
            }
        )
end)



RegisterServerEvent("bank:DeleteAccounts")
AddEventHandler("bank:DeleteAccounts",function(id)
    MySQL.Async.execute(
        "DELETE FROM banking_account where id=@id",
        {
            ["@id"] = id,

        }
    )
    MySQL.Async.execute(
        "DELETE FROM banking_cards where account=@id",
        {
            ["@id"] = id,

        }
    )
end)

RegisterServerEvent("bankBlockAcc")
AddEventHandler("bankBlockAcc",function(check,id)
    MySQL.Async.execute(
        "UPDATE banking_account SET bloqued=@check where id=@id",
        {
            ["@id"] = id,
            ["@check"] = check,
        }
    )
end)

RegisterServerCallback("createAccount",function(source, callback,tab)
    local unique = false
    local table = nil
    MySQL.Async.fetchAll(
        "SELECT * FROM banking_account",
        {
        },
        function(result)

        while not unique do
            Wait(1)
            table = "LS-"..math.random(11111111,99999999)
            local found = false
            for i = 1 , #result , 1 do
                if result[i].iban == table then
                    found = true

                end
            end
            if not found then
                unique = true
            end
        end
    end)
    while table == nil do
        Wait(1)
    end
    MySQL.Async.execute(
        "INSERT INTO banking_account (label,uuid,iban,phone_number) VALUES(@label,@uuid,@iban,@phone_number)",
           {
                ['@label']   = tab.name,
                ['@uuid']   = tab.uuid,
                ['@iban']   = table,
                ['@phone_number']   = tab.number,
            }
        )
        callback(table)
end)
RegisterServerCallback("newCard",function(source, callback,tab,id,type)
    local number = nil
    GenerateNumber(function(t)
        print(t)
        number = t
    end)
    while number == nil do
        Wait(1)
      --  print("o")
    end
    MySQL.Async.execute(
        "INSERT INTO banking_cards (type,uuid,account,code,number,current_ratio) VALUES(@type,@uuid,@account,@code,@number,@current_ratio)",
           {
                ['@type']   = type,
                ['@uuid']   = tab.uuid,
                ['@account']   = id,
                ['@code']   = tab.code,
                ['@number']   =number,
                ['@current_ratio'] = json.encode(ratios[type])
            }
        )
        callback(number,ratios[type])
end)
RegisterServerEvent('bankingRemoveFromAccount')
AddEventHandler('bankingRemoveFromAccount', function(name,rem,dat)
    local source = source
    local account = Banking.GetAccount(name)
    while account.getMoney() == nil do 
        Wait(1)
    end
    if 0 <= account.getMoney()-rem then
        account.removeMoney(rem)
        account.quotas = dat
        local player = Player.GetPlayer(source)
        player.addMoney(rem)
    end
end)
RegisterServerEvent('bank:GenerateBankAccount')
AddEventHandler('bank:GenerateBankAccount', function()
    local ply = Player.GetPlayer(source)
    MySQL.Async.fetchAll(
        "SELECT * FROM banking_account",
        {
        },
        function(result)
            local unique = false
            local table = nil
        while not unique do
            Wait(1)
            table = "LS-"..math.random(11111111,99999999)
            local found = false
            for i = 1 , #result , 1 do
                if result[i].iban == table then
                    found = true

                end
            end
            if not found then
                unique = true
            end
        end
    MySQL.Async.execute(
        "INSERT INTO banking_account (label,uuid,amount,iban) VALUES(@label,@owner,@amount,@iban)",
           {
                ['@label']   = "Compte personnel",
                ['@owner']   =ply.uuid,
                ['@amount']   = 500,
                ['@iban']   = "LS-"..math.random(11111111,99999999), 
            }
        )

        end
    )
end)
RegisterServerEvent('bankingAddFromAccount')
AddEventHandler('bankingAddFromAccount', function(name,rem,dat)
    local source = source
    local account = Banking.GetAccount(name)
    while account.getMoney() == nil do 
        Wait(1)
    end

        account.addMoney(rem )
        account.quotas = dat
        local player = Player.GetPlayer(source)        
        player.removeMoney(rem)

end)

RegisterServerEvent('bankingSendMoney')
AddEventHandler('bankingSendMoney', function(target,money,src)
    local targetAccount = Banking.GetAccount(target)
    local srcAccount = Banking.GetAccount(src)
    while targetAccount.getMoney() == nil do 
        Wait(1)
    end
    while srcAccount.getMoney() == nil do 
        Wait(1)
    end
    targetAccount.addMoney(money )
    srcAccount.removeMoney(money)

    for k,v in pairs(Users) do
        if v.uuid == srcAccount.uuid then
            TriggerClientEvent("RageUI:Popup", v.source, {message="Vous avez reçu un nouveau virement de " .. money .."$ de la part du compte " .. src})
            break
        end
    end
end)


RegisterServerEvent('entreprise:Add')
AddEventHandler('entreprise:Add', function(target,money)
    local targetAccount = Banking.GetAccount(target)
    while targetAccount.getMoney() == nil do 
        Wait(1)
    end
    targetAccount.addMoney(money )

end)



RegisterServerEvent('bank:Add')
AddEventHandler('bank:Add', function(id,uuid)
    MySQL.Async.execute(
        "UPDATE banking_account SET coowner=@uuid where id=@id",
        {
            ["@id"] = id,
            ["@uuid"] = uuid,
        }
    )
end)
