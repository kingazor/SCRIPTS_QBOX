Config = {}

-- Configurações Gerais
Config.Debug = false -- Ativar mensagens de debug
Config.NotificationCooldown = 5000 -- 5 segundos em milissegundos

-- Configurações de Inventário
Config.MaxInventorySlots = 50

-- Configurações de Itens
Config.RequiredItem = "empty_bucket" -- Item necessário para coletar
Config.RequiredTool = "WEAPON_BOTTLE" -- Arma necessária para coletar
Config.RewardItem = "latex" -- Item que será dado como recompensa

-- Configurações de Coleta
Config.MinLatexAmount = 1 -- Quantidade mínima de látex que pode ser coletada
Config.MaxLatexAmount = 3 -- Quantidade máxima de látex que pode ser coletada
Config.CooldownTime = 5 -- Tempo de cooldown em minutos

-- Configurações de Animação
Config.AnimationSettings = {
    dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
    name = "machinic_loop_mechandplayer",
    duration = 5000, -- Duração da animação em ms
    flags = 1
}

-- Configurações do Progressbar
Config.ProgressbarSettings = {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true
}

-- Configurações do Target
Config.TargetSettings = {
    icon = "fas fa-tree",
    label = "Coletar Látex",
    distance = 2.0
}

-- Configurações do Blip
Config.BlipSettings = {
    sprite = 93,
    display = 4,
    scale = 0.7,
    color = 2,
    shortRange = true,
    name = "Seringal"
}

-- Configurações de Localização
Config.SeringalLocation = {
    x = -1863.0,
    y = 2092.0,
    z = 140.0
}

-- Configurações do Modelo
Config.TargetModel = "prop_tree_oak_01" -- Modelo da árvore para target
Config.TargetModelHash = 381625293 -- Hash do modelo da árvore

-- Configurações de Notificações
Config.Notifications = {
    collecting = "Coletando látex...",
    success = "Você coletou látex!",
    noItem = "Você precisa de um balde vazio!",
    noWeapon = "Você precisa da ferramenta de coleta!",
    noSpace = "Você não tem espaço no inventário!",
    cooldown = "Esta árvore precisa de tempo para regenerar!",
    cancel = "Cancelado!"
}

-- Função para debug
if Config.Debug then
    print('^2[DEBUG] Configurações carregadas:^7')
    print('^2[DEBUG] Item necessário: ' .. Config.RequiredItem)
    print('^2[DEBUG] Item recompensa: ' .. Config.RewardItem)
    print('^2[DEBUG] Ferramenta necessária: ' .. Config.RequiredTool)
    print('^2[DEBUG] Modelo da árvore: ' .. Config.TargetModel)
    print('^2[DEBUG] Hash do modelo: ' .. Config.TargetModelHash)
    print('^2[DEBUG] Mínimo de látex: ' .. Config.MinLatexAmount)
    print('^2[DEBUG] Máximo de látex: ' .. Config.MaxLatexAmount)
    print('^2[DEBUG] Tempo de cooldown: ' .. Config.CooldownTime)
end 