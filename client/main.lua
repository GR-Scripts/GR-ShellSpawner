local spawnedShells = {}

CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(100)
    end
    TriggerServerEvent("gr-shellspawner:requestShells")
end)

RegisterNetEvent("gr-shellspawner:spawnShells", function(shells)
    for _, shell in ipairs(shells) do
        local model = GetHashKey(shell.model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(10)
        end

        local coords = shell.coords
        local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, false)
        SetEntityRotation(obj, shell.rotation.x, shell.rotation.y, shell.rotation.z, 2, true)
        FreezeEntityPosition(obj, true)

        table.insert(spawnedShells, obj)
    end
end)

RegisterNetEvent("gr-shellspawner:clearShells", function()
    for _, obj in ipairs(spawnedShells) do
        if DoesEntityExist(obj) then
            DeleteObject(obj)
        end
    end
    spawnedShells = {}
end)
