

ESX.RegisterCommand({'staffann'}, 'admin', function(xPlayer, args, showError)
    if args.text ~= "" then
        local type = "staff"
        local msg = args.text
        local timer = 7000
        local id = "staffann999"
        TriggerClientEvent("cdtnotifs:notificationpush", -1, type, msg, timer, id)
    else
        print("aucun texte saisi...")
    end
end, true,
    {
        help = "Annonce staff",
        validate = true,
        arguments = {
            { name = "text", validate = true, help = "Saise du texte", type = "string" },
        },
    }

)