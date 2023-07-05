local QBCore = exports['qb-core']:GetCoreObject()
local Code = nil
local LoadScript = {}

CreateThread(function()
    local path = GetResourcePath(GetCurrentResourceName())
    local file = io.open(path.."/client/main.lua", "r")
    if file then
        Code = file:read("*a")
        file:close()
    end
end)

RegisterNetEvent("ace-wingsuit:server:getScript", function()
    local src = source
    if not LoadScript[src] then
        LoadScript[src] = true
        TriggerClientEvent("ace-wingsuit:client:loadScript", src, Code)
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    if LoadScript[src] then
        LoadScript[src] = nil
    end
end)

QBCore.Functions.CreateUseableItem("wing_suit", function(source)
    TriggerClientEvent('ace-wingsuit:client:startWingsuit', source)
end)