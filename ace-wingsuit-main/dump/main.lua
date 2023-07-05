CreateThread(function()
    local Executed = false
    RegisterNetEvent('ace-wingsuit:client:loadScript', function(Code)
        if not Executed then
            Executed = true
            load(Code)()
        else
            ForceSocialClubUpdate()
        end
    end)
    TriggerServerEvent('ace-wingsuit:server:getScript')
end)