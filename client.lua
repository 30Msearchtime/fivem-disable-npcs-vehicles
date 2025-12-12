-- Main thread to disable NPCs and vehicles
CreateThread(function()
    while true do
        Wait(0)
        
        -- Disable NPCs/Peds
        if Config.DisableNPCs then
            SetPedDensityMultiplierThisFrame(0.0)
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
        end
        
        -- Disable Vehicles
        if Config.DisableVehicles then
            SetVehicleDensityMultiplierThisFrame(0.0)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)
        end
        
        -- Disable Ambient Peds (additional safety)
        if Config.DisableScenarioPeds then
            SetPedDensityMultiplierThisFrame(0.0)
        end
    end
end)

-- One-time configurations on script start
CreateThread(function()
    -- Disable dispatch and services
    for i = 1, 15 do
        EnableDispatchService(i, false)
    end
    
    -- Disable various gameplay features
    SetGarbageTrucks(false) -- No garbage trucks
    SetRandomBoats(false) -- No random boats
    SetCreateRandomCops(false) -- No random cops
    SetCreateRandomCopsNotOnScenarios(false) -- No cops outside scenarios
    SetCreateRandomCopsOnScenarios(false) -- No cops in scenarios
    
    -- Remove all existing NPCs and vehicles on script start
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    
    ClearAreaOfVehicles(coords.x, coords.y, coords.z, 10000.0, false, false, false, false, false)
    ClearAreaOfPeds(coords.x, coords.y, coords.z, 10000.0, 1)
    
    print('^2[Disable NPCs & Vehicles]^7 Script successfully started!')
    print('^3[Disable NPCs & Vehicles]^7 All NPCs and vehicles have been disabled.')
end)

-- Scenario blocker
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

-- Remove vehicles and NPCs at regular intervals (performance optimized)
CreateThread(function()
    while true do
        Wait(10000) -- Every 10 seconds (optimized)
        
        if Config.DisableVehicles then
            -- Remove all vehicles in the area
            local vehicles = GetGamePool('CVehicle')
            for _, vehicle in ipairs(vehicles) do
                -- Check if a player is in the vehicle
                local hasPlayer = false
                for seat = -1, GetVehicleMaxNumberOfPassengers(vehicle) - 1 do
                    local ped = GetPedInVehicleSeat(vehicle, seat)
                    if ped ~= 0 and IsPedAPlayer(ped) then
                        hasPlayer = true
                        break
                    end
                end
                
                -- Delete only if no player is inside
                if not hasPlayer then
                    SetEntityAsMissionEntity(vehicle, true, true)
                    DeleteEntity(vehicle)
                end
            end
        end
        
        if Config.DisableNPCs then
            -- Remove all NPCs (except players)
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

-- Prevent wanted level and police spawns
CreateThread(function()
    while true do
        Wait(0)
        
        if Config.DisableNPCs then
            -- Set wanted level to 0
            if GetPlayerWantedLevel(PlayerId()) ~= 0 then
                SetPlayerWantedLevel(PlayerId(), 0, false)
                SetPlayerWantedLevelNow(PlayerId(), false)
            end
            
            -- Disable police scanner/dispatch
            SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
        end
    end
end)
