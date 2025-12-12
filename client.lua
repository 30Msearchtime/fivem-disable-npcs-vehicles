-- Haupt-Thread zum Deaktivieren von NPCs und Fahrzeugen
CreateThread(function()
    while true do
        Wait(0)
        
        -- Deaktiviere NPCs/Peds
        if Config.DisableNPCs then
            SetPedDensityMultiplierThisFrame(0.0)
            SetVehicleDensityMultiplierThisFrame(0.0)
        end
        
        -- Deaktiviere Fahrzeuge
        if Config.DisableVehicles then
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)
        end
        
        -- Deaktiviere Szenario-Peds
        if Config.DisableScenarioPeds then
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
        end
    end
end)

-- Zusätzliche Natives für bessere Performance
CreateThread(function()
    -- Diese Befehle müssen nur einmal ausgeführt werden
    
    -- Deaktiviere Parked Vehicles
    if Config.DisableParkedVehicles then
        SetVehicleDensityMultiplierThisFrame(0.0)
    end
    
    -- Entferne alle existierenden NPCs und Fahrzeuge beim Script-Start
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    
    ClearAreaOfVehicles(coords.x, coords.y, coords.z, 1000.0, false, false, false, false, false)
    ClearAreaOfPeds(coords.x, coords.y, coords.z, 1000.0, 1)
    
    print('^2[Disable NPCs & Vehicles]^7 Script erfolgreich gestartet!')
end)

-- Optional: Entferne Fahrzeuge und NPCs in regelmäßigen Abständen
CreateThread(function()
    while true do
        Wait(5000) -- Alle 5 Sekunden
        
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        
        if Config.DisableVehicles then
            -- Entferne alle Fahrzeuge im Umkreis
            local vehicles = GetGamePool('CVehicle')
            for _, vehicle in ipairs(vehicles) do
                if not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
                    DeleteEntity(vehicle)
                end
            end
        end
        
        if Config.DisableNPCs then
            -- Entferne alle NPCs (außer Spieler)
            local peds = GetGamePool('CPed')
            for _, ped in ipairs(peds) do
                if not IsPedAPlayer(ped) then
                    DeleteEntity(ped)
                end
            end
        end
    end
end)
