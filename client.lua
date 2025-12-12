-- Haupt-Thread zum Deaktivieren von NPCs und Fahrzeugen
CreateThread(function()
    while true do
        Wait(0)
        
        -- Deaktiviere NPCs/Peds
        if Config.DisableNPCs then
            SetPedDensityMultiplierThisFrame(0.0)
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
        end
        
        -- Deaktiviere Fahrzeuge
        if Config.DisableVehicles then
            SetVehicleDensityMultiplierThisFrame(0.0)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)
        end
        
        -- Deaktiviere Ambient Peds (zusätzliche Sicherheit)
        if Config.DisableScenarioPeds then
            SetPedDensityMultiplierThisFrame(0.0)
        end
    end
end)

-- Einmalige Konfigurationen beim Script-Start
CreateThread(function()
    -- Dispatch und Services deaktivieren
    for i = 1, 15 do
        EnableDispatchService(i, false)
    end
    
    -- Deaktiviere verschiedene Gameplay-Features
    SetGarbageTrucks(false) -- Keine Müllwagen
    SetRandomBoats(false) -- Keine zufälligen Boote
    SetCreateRandomCops(false) -- Keine zufälligen Polizisten
    SetCreateRandomCopsNotOnScenarios(false) -- Keine Polizisten außerhalb von Szenarien
    SetCreateRandomCopsOnScenarios(false) -- Keine Polizisten in Szenarien
    
    -- Entferne alle existierenden NPCs und Fahrzeuge beim Script-Start
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    
    ClearAreaOfVehicles(coords.x, coords.y, coords.z, 10000.0, false, false, false, false, false)
    ClearAreaOfPeds(coords.x, coords.y, coords.z, 10000.0, 1)
    
    print('^2[Disable NPCs & Vehicles]^7 Script successfully started!')
    print('^3[Disable NPCs & Vehicles]^7 All NPCs and vehicles have been disabled.')
end)

-- Szenarien-Blocker
CreateThread(function()
    local scenarios = {
        'WORLD_VEHICLE_ATTRACTOR',
        'WORLD_VEHICLE_AMBULANCE',
        'WORLD_VEHICLE_BICYCLE_BMX',
        'WORLD_VEHICLE_BICYCLE_BMX_BALLAS',
        'WORLD_VEHICLE_BICYCLE_MOUNTAIN',
        'WORLD_VEHICLE_BICYCLE_ROAD',
        'WORLD_VEHICLE_BIKE_OFF_ROAD_RACE',
        'WORLD_VEHICLE_BIKER',
        'WORLD_VEHICLE_BOAT_IDLE',
        'WORLD_VEHICLE_BOAT_IDLE_ALAMO',
        'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
        'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
        'WORLD_VEHICLE_BROKEN_DOWN',
        'WORLD_VEHICLE_BUSINESSMEN',
        'WORLD_VEHICLE_HELI_LIFEGUARD',
        'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',
        'WORLD_VEHICLE_CONSTRUCTION_SOLO',
        'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',
        'WORLD_VEHICLE_DRIVE_PASSENGERS',
        'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',
        'WORLD_VEHICLE_DRIVE_SOLO',
        'WORLD_VEHICLE_FIRE_TRUCK',
        'WORLD_VEHICLE_EMPTY',
        'WORLD_VEHICLE_MARIACHI',
        'WORLD_VEHICLE_MECHANIC',
        'WORLD_VEHICLE_MILITARY_PLANES_BIG',
        'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
        'WORLD_VEHICLE_PARK_PARALLEL',
        'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',
        'WORLD_VEHICLE_PASSENGER_EXIT',
        'WORLD_VEHICLE_POLICE_BIKE',
        'WORLD_VEHICLE_POLICE_CAR',
        'WORLD_VEHICLE_POLICE',
        'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
        'WORLD_VEHICLE_QUARRY',
        'WORLD_VEHICLE_SALTON',
        'WORLD_VEHICLE_SALTON_DIRT_BIKE',
        'WORLD_VEHICLE_SECURITY_CAR',
        'WORLD_VEHICLE_STREETRACE',
        'WORLD_VEHICLE_TOURBUS',
        'WORLD_VEHICLE_TOURIST',
        'WORLD_VEHICLE_TANDL',
        'WORLD_VEHICLE_TRACTOR',
        'WORLD_VEHICLE_TRACTOR_BEACH',
        'WORLD_VEHICLE_TRUCK_LOGS',
        'WORLD_VEHICLE_TRUCKS_TRAILERS',
        'WORLD_VEHICLE_DISTANT_EMPTY_GROUND'
    }
    
    for _, scenario in ipairs(scenarios) do
        SetScenarioTypeEnabled(scenario, false)
    end
end)

-- Entferne Fahrzeuge und NPCs in regelmäßigen Abständen (Performance-optimiert)
CreateThread(function()
    while true do
        Wait(10000) -- Alle 10 Sekunden (optimiert)
        
        if Config.DisableVehicles then
            -- Entferne alle Fahrzeuge im Umkreis
            local vehicles = GetGamePool('CVehicle')
            for _, vehicle in ipairs(vehicles) do
                -- Prüfe ob ein Spieler im Fahrzeug sitzt
                local hasPlayer = false
                for seat = -1, GetVehicleMaxNumberOfPassengers(vehicle) - 1 do
                    local ped = GetPedInVehicleSeat(vehicle, seat)
                    if ped ~= 0 and IsPedAPlayer(ped) then
                        hasPlayer = true
                        break
                    end
                end
                
                -- Lösche nur wenn kein Spieler drin ist
                if not hasPlayer then
                    SetEntityAsMissionEntity(vehicle, true, true)
                    DeleteEntity(vehicle)
                end
            end
        end
        
        if Config.DisableNPCs then
            -- Entferne alle NPCs (außer Spieler)
            local peds = GetGamePool('CPed')
            for _, ped in ipairs(peds) do
                if not IsPedAPlayer(ped) and GetPedType(ped) ~= 28 then -- 28 = Player Ped Type
                    SetEntityAsMissionEntity(ped, true, true)
                    DeleteEntity(ped)
                end
            end
        end
    end
end)

-- Verhindere Wanted Level und Polizei-Spawns
CreateThread(function()
    while true do
        Wait(0)
        
        if Config.DisableNPCs then
            -- Setze Wanted Level auf 0
            if GetPlayerWantedLevel(PlayerId()) ~= 0 then
                SetPlayerWantedLevel(PlayerId(), 0, false)
                SetPlayerWantedLevelNow(PlayerId(), false)
            end
            
            -- Deaktiviere Polizei-Scanner/Dispatch
            SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
        end
    end
end)
