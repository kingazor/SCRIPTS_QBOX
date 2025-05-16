local QBCore = exports['qb-core']:GetCoreObject()
local cooldownTrees = {}

-- Evento para coletar látex
RegisterNetEvent('latex:server:collectLatex', function(treeId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    -- Verificar se o jogador tem o item necessário
    local hasItem = Player.Functions.GetItemByName(Config.RequiredItem)
    if not hasItem then
        TriggerClientEvent('QBCore:Notify', src, Config.Notifications.noItem, 'error')
        return
    end
    
    -- Gerar quantidade aleatória de látex
    local amount = math.random(Config.MinLatexAmount, Config.MaxLatexAmount)
    
    -- Verificar se o jogador tem espaço no inventário e adicionar o item
    local hasSpace = Player.Functions.AddItem(Config.RewardItem, amount)
    if not hasSpace then
        TriggerClientEvent('QBCore:Notify', src, Config.Notifications.noSpace, 'error')
        return
    end
    
    -- Remover o balde vazio
    Player.Functions.RemoveItem(Config.RequiredItem, 1)
    
    -- Atualizar o cooldown da árvore
    cooldownTrees[treeId] = os.time()
    
    -- Notificar o jogador
    TriggerClientEvent('QBCore:Notify', src, Config.Notifications.success, 'success')
    TriggerClientEvent('latex:client:updateCooldown', src, treeId)
end)

-- Evento para verificar o cooldown da árvore
RegisterNetEvent('latex:server:checkCooldown', function(treeId, cb)
    local src = source
    if cooldownTrees[treeId] then
        local currentTime = os.time()
        if (currentTime - cooldownTrees[treeId]) < (Config.CooldownTime * 60) then
            cb(false)
            return
        end
    end
    cb(true)
end) 