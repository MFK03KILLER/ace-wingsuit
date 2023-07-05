local WingSuitOpen = false
local WingSuitObject = nil
local OpenedObject = nil
local BoostTime = 0

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    if WingSuitOpen then
        local HasWingSuit = false
        for _, item in pairs(val.items) do
            if item.name == "wing_suit" then
                HasWingSuit = true
                break
            end
        end
        if not HasWingSuit then
            TriggerEvent('ace-wingsuit:client:startWingsuit')
        end
    end
end)

RegisterNetEvent('ace-wingsuit:client:startWingsuit', function()
    local ped = PlayerPedId()

    if WingSuitOpen then
        WingSuitOpen = false
        DeleteEntity(WingSuitObject)
        WingSuitObject = nil
        if OpenedObject then
            DeleteEntity(OpenedObject)
            OpenedObject = nil
            BoostTime = 0
        end
        RemoveWeaponFromPed(ped, -72657034)
        return 
    end

    if IsPedInAnyVehicle(ped) or GetEntityHeightAboveGround(ped) > 3 then  return end
  
    WingSuitOpen = true

    local hash = GetHashKey("np_wingsuit_closed")
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(100)
    end
    WingSuitObject = CreateObject(hash, GetEntityCoords(ped), true, true, true)
    AttachEntityToEntity(WingSuitObject, ped, GetPedBoneIndex(ped, 24816), 0.2, -0.2, 0.0, 0.0, 90.0, 0.0, true, true, false, false, 1, true)

    CreateThread(function()
        while WingSuitOpen do
            Wait(500)
            if WingSuitOpen and not HasPedGotWeapon(ped, -72657034, false) and not OpenedObject and GetEntityHeightAboveGround(ped) < 3 then
                SetPlayerParachuteModelOverride(PlayerId(), `p_parachute1_mp_s`)
                SetPedParachuteTintIndex(ped, 6)
                GiveWeaponToPed(ped, -72657034, 1, 0, 1)
            end
        end
    end)
    CreateThread(function()
        ::Again::
        while not IsPedInParachuteFreeFall(ped) do
            Wait(100)
        end
        while (GetEntityHeightAboveGround(ped) > 1) and (GetPedParachuteState(ped) < 1) do
            Wait(500)
        end
        if OpenedObject then
            DeleteEntity(OpenedObject)
            OpenedObject = nil
            BoostTime = 0
        end
        if WingSuitOpen then
            goto Again
        end
    end)
    CreateThread(function()
        while WingSuitOpen do 
            Wait(10)
            if IsPedInParachuteFreeFall(ped) then
                if not OpenedObject then 
                    local OpenModel = GetHashKey("np_wingsuit_open")
                    RequestModel(OpenModel)
                    while not HasModelLoaded(OpenModel) do
                        Wait(100)
                    end
                    OpenedObject = CreateObject(OpenModel, GetEntityCoords(PlayerPedId()), true, true, true)
                    AttachEntityToEntity(OpenedObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 24816), 0.2, -0.2, 0.0, 0.0, 90.0, 0.0, true, true, false, false, 1, true)
                else
                    if IsControlPressed(0, 38) and BoostTime < 400 then
                        BoostTime = BoostTime + 1
                        ApplyForceToEntity(ped, true, 0.0, 2.5, 200.0, 0.0, 0.0, 0.0, false, true, false, false, false, true)
                    end
                end
            end
        end
    end)
end)