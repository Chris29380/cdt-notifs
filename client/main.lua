CDT = exports['cdt-lib']:getCDTLib()


-- locals

local notiftable = {}


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
    Citizen.Wait(2000)
    -- call triggers
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)


RegisterNetEvent('onResourceStart')
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then 
        Citizen.Wait(300)
        -- call trigger
    end
end)

RegisterNetEvent('onResourceStop')
AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then 
        
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function notifpush(type,msg,timer,id)
    if notiftable then
        if #notiftable > 0 then
            local findId = false
            if id then
                for k,v in pairs(notiftable) do
                    if v.idn == id then
                        findId = true
                    end
                end
                if findId == false then
                    TriggerEvent("cdtnotifs:notificationpush", type, msg,timer,id)
                end
            else
                TriggerEvent("cdtnotifs:notificationpush", type, msg,timer,id)
                print("no idnotif")
            end
        else
            TriggerEvent("cdtnotifs:notificationpush", type, msg,timer,id)
        end
    else
        TriggerEvent("cdtnotifs:notificationpush", type, msg,timer,id)
        print("no notiftable")
    end
end

RegisterNetEvent("cdtnotifs:notificationpush")
AddEventHandler("cdtnotifs:notificationpush", function (type, msg, timer, id)
    local idnotif
    local randomid
    local typeN, typeD
    local timerN, timerD
    local findtype = false

    randomid = "notif"..math.random(150,10000)
    idnotif = id or randomid

    for i = 1, #Options.types do
        if Options.types[i].type == type then
            typeN = type
            findtype = true
        end
        if Options.types[i].default == true then
            typeD = Options.types[i].type
            timerD = Options.types[i].timer
        end
    end
    if findtype == false then
        typeN = typeD
    end
    timerN = timer or timerD

    if notiftable and #notiftable > 0 then
        print("#notiftable "..#notiftable)
        while #notiftable >= 5 do
            Wait(500)
        end
        table.insert(notiftable, {idn = idnotif})
        print('notiftable '..json.encode(notiftable))
        showNotif(typeN,msg,timerN,idnotif)
    else
        table.insert(notiftable, {idn = idnotif})
        print('notiftable '..json.encode(notiftable))
        showNotif(typeN,msg,timerN,idnotif)
    end
end)

function showNotif(type, msg, timer, idn)
    SendNUIMessage(
        {
            type="sendNotif",
            typeN = type,
            types = Options.types,
            msg = msg,
            timer = timer,
            idn = idn,
        }
    )
end

RegisterNuiCallback("delnotifidn", function (data)
    if notiftable then
        if #notiftable > 0 then
            for i = 1, #notiftable do
                for k,v in pairs(notiftable) do
                    if v.idn == data.idnotif then
                        table.remove(notiftable, k)
                    end
                end
            end 
        else
            print("#notiftable = 0")
        end
    else
        print("no notiftable")
    end
    print('notiftable '..json.encode(notiftable))
end)

exports('showNotification', function(type,msg,timer,id)
	notifpush(type,msg,timer,id)
end)

RegisterCommand("notiftest", function ()
    for i = 1,10 do
       local type = "success"
       local msg = "Creating script environnements for cdt dev."
       local timer = 4500
       notifpush(type,msg,timer)
       Wait(500)
       local type = "info"
       local msg = "Creating script environnements for cdt dev."
       local timer = 4500
       notifpush(type,msg,timer)
       Wait(500)
       local type = "error"
       local msg = "Creating script environnements for cdt dev."
       local timer = 4500
       notifpush(type,msg,timer)
       Wait(500)
    end    
end, false)

RegisterCommand("notiftestid", function ()
    for i = 1,10 do
       local type = "success"
       local msg = "Creating script environnements for cdt dev."
       local timer = 4500
       local id = "test"
       notifpush(type,msg,timer,id)
       Wait(500)
       local type = "success"
       local msg = "Creating script environnements for cdt dev."
       local timer = 4500
       local id = "test"
       notifpush(type,msg,timer,id)
       Wait(500)
       local type = "success"
       local msg = "Creating script environnements for cdt dev."
       local timer = 4500
       local id = "test"
       notifpush(type,msg,timer,id)
       Wait(500)
    end    
end, false)