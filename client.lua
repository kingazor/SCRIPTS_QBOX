local QBCore = exports['qb-core']:GetCoreObject()
local cooldownTrees = {}
local lastNotificationTime = 0
local NOTIFICATION_COOLDOWN = Config.NotificationCooldown

-- Criar blip do Seringal
CreateThread(function()
    local blip = AddBlipForCoord(Config.SeringalLocation.x, Config.SeringalLocation.y, Config.SeringalLocation.z)
    SetBlipSprite(blip, Config.BlipSettings.sprite)
    SetBlipDisplay(blip, Config.BlipSettings.display)
    SetBlipScale(blip, Config.BlipSettings.scale)
    SetBlipColour(blip, Config.BlipSettings.color)
    SetBlipAsShortRange(blip, Config.BlipSettings.shortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.BlipSettings.name)
    EndTextCommandSetBlipName(blip)
end)

-- Função para verificar se o jogador tem o item necessário
local function HasRequiredItem()
    local Player = QBCore.Functions.GetPlayerData()
    local hasItem = false
    
    if Player.items then
        for _, item in pairs(Player.items) do
            if item and item.name == Config.RequiredItem then
                hasItem = true
                break
            end
        end
    end
    
    return hasItem
end

-- Função para verificar se o jogador tem a arma necessária
local function HasRequiredWeapon()
    local ped = PlayerPedId()
    local currentWeapon = GetSelectedPedWeapon(ped)
    return currentWeapon == GetHashKey(Config.RequiredTool)
end

-- Função para verificar se o jogador tem espaço no inventário
local function HasInventorySpace()
    local Player = QBCore.Functions.GetPlayerData()
    local hasItem = false
    
    if Player.items then
        for _, item in pairs(Player.items) do
            if item and item.name == Config.RewardItem then
                hasItem = true
                break
            end
        end
    end
    
    return not hasItem
end

-- Função para verificar o cooldown da árvore
local function IsTreeOnCooldown(treeId)
    if cooldownTrees[treeId] then
        local currentTime = GetGameTimer()
        if (currentTime - cooldownTrees[treeId]) < (Config.CooldownTime * 60 * 1000) then
            return true
        end
    end
    return false
end

-- Função para verificar se pode mostrar notificação
local function CanShowNotification()
    local currentTime = GetGameTimer()
    if currentTime - lastNotificationTime >= NOTIFICATION_COOLDOWN then
        lastNotificationTime = currentTime
        return true
    end
    return false
end

-- Função para verificar todos os requisitos
local function CheckRequirements()
    local missingItems = {}
    
    if not HasRequiredItem() then
        table.insert(missingItems, "Balde vazio")
    end
    
    if not HasRequiredWeapon() then
        table.insert(missingItems, "Ferramenta de coleta")
    end
    
    if #missingItems > 0 then
        if CanShowNotification() then
            local message = "Você precisa de: " .. table.concat(missingItems, ", ")
            QBCore.Functions.Notify(message, 'error', 5000)
        end
        return false
    end
    
    return true
end

-- Função para coletar látex
local function CollectLatex(treeId)
    if not CheckRequirements() then return end

    if IsTreeOnCooldown(treeId) then
        if CanShowNotification() then
            QBCore.Functions.Notify(Config.Notifications.cooldown, 'error')
        end
        return
    end

    -- Iniciar animação
    RequestAnimDict(Config.AnimationSettings.dict)
    while not HasAnimDictLoaded(Config.AnimationSettings.dict) do
        Wait(10)
    end

    TaskPlayAnim(PlayerPedId(), Config.AnimationSettings.dict, Config.AnimationSettings.name, 8.0, -8.0, -1, Config.AnimationSettings.flags, 0, false, false, false)

    QBCore.Functions.Progressbar("collecting_latex", Config.Notifications.collecting, Config.AnimationSettings.duration, false, true, Config.ProgressbarSettings, {
        animDict = Config.AnimationSettings.dict,
        anim = Config.AnimationSettings.name,
        flags = Config.AnimationSettings.flags,
    }, {}, {}, function() -- Done
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('latex:server:collectLatex', treeId)
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify(Config.Notifications.cancel, "error")
    end)
end

-- Função para verificar se o modelo é válido
local function IsValidTreeModel(model)
    local modelHash = GetHashKey(model)
    return Config.TargetModelHashes[modelHash] ~= nil
end

-- Registrar o target para as árvores
CreateThread(function()
    Wait(1000) -- Esperar um pouco para garantir que tudo carregou

    -- Registrar target para o modelo específico
    exports['qb-target']:AddTargetModel(Config.TargetModel, {
        options = {
            {
                num = 1,
                type = "client",
                event = "latex:client:collectLatex",
                icon = Config.TargetSettings.icon,
                label = Config.TargetSettings.label,
                canInteract = function()
                    if not HasRequiredItem() then
                        if CanShowNotification() then
                            QBCore.Functions.Notify(Config.Notifications.noItem, 'error', 3000)
                        end
                        return false
                    end
                    if not HasRequiredWeapon() then
                        if CanShowNotification() then
                            QBCore.Functions.Notify(Config.Notifications.noWeapon, 'error', 3000)
                        end
                        return false
                    end
                    return true
                end,
            },
        },
        distance = Config.TargetSettings.distance,
    })

    -- Registrar target para o hash específico
    exports['qb-target']:AddTargetModel(Config.TargetModelHash, {
        options = {
            {
                num = 2,
                type = "client",
                event = "latex:client:collectLatex",
                icon = Config.TargetSettings.icon,
                label = Config.TargetSettings.label,
                canInteract = function()
                    if not HasRequiredItem() then
                        if CanShowNotification() then
                            QBCore.Functions.Notify(Config.Notifications.noItem, 'error', 3000)
                        end
                        return false
                    end
                    if not HasRequiredWeapon() then
                        if CanShowNotification() then
                            QBCore.Functions.Notify(Config.Notifications.noWeapon, 'error', 3000)
                        end
                        return false
                    end
                    return true
                end,
            },
        },
        distance = Config.TargetSettings.distance,
    })
end)

-- Evento para coletar látex
RegisterNetEvent('latex:client:collectLatex', function(data)
    local treeId = data.entity
    CollectLatex(treeId)
end)

-- Evento para atualizar o cooldown da árvore
RegisterNetEvent('latex:client:updateCooldown', function(treeId)
    cooldownTrees[treeId] = GetGameTimer()
end) 