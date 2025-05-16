# Sistema de Coleta de Látex

Este é um sistema para FiveM que permite aos jogadores coletarem látex de árvores específicas usando um balde vazio e uma garrafa.

## 📋 Requisitos

- FiveM Server
- QBCore Framework
- qb-target
- qb-core

## 🚀 Instalação

1. Baixe ou clone este repositório
2. Coloque a pasta `Coleta_Latex` em seu diretório de recursos (`resources/`)
3. Adicione `ensure Coleta_Latex` ao seu `server.cfg`
4. Reinicie seu servidor

## ⚙️ Configuração

### Itens Necessários
Adicione os seguintes itens ao seu `qb-core/shared/items.lua`:

```lua
['empty_bucket'] = {
    ['name'] = 'empty_bucket',
    ['label'] = 'Balde Vazio',
    ['weight'] = 1000,
    ['type'] = 'item',
    ['image'] = 'empty_bucket.png',
    ['unique'] = false,
    ['useable'] = true,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'Um balde vazio para coletar látex'
},
['latex'] = {
    ['name'] = 'latex',
    ['label'] = 'Látex',
    ['weight'] = 1000,
    ['type'] = 'item',
    ['image'] = 'latex.png',
    ['unique'] = false,
    ['useable'] = false,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'Látex natural coletado das árvores'
}
```

### Configurações Personalizáveis
No arquivo `config.lua` você pode ajustar:

- Itens necessários para coleta
- Quantidade mínima e máxima de látex
- Tempo de cooldown entre coletas
- Localização do seringal
- Configurações do blip
- Animações e notificações

## 🎮 Como Usar

1. Obtenha um balde vazio
2. Equipe uma garrafa (WEAPON_BOTTLE)
3. Vá até o seringal (marcado no mapa)
4. Aproxime-se de uma árvore de carvalho (prop_tree_oak_01)
5. Use o target (ALT) para coletar o látex
6. Aguarde a animação terminar
7. O látex será adicionado ao seu inventário

## ⚠️ Observações

- Cada árvore tem um cooldown de 5 minutos entre coletas
- Você precisa ter espaço no inventário para receber o látex
- O sistema verifica se você tem os itens necessários antes de permitir a coleta

## 🔧 Solução de Problemas

Se encontrar algum problema:

1. Verifique se todos os requisitos estão instalados
2. Confirme se os itens foram adicionados corretamente
3. Verifique se o qb-target está funcionando
4. Certifique-se de que as coordenadas do seringal estão corretas

## 📝 Notas de Atualização

### Versão 1.0
- Sistema inicial de coleta de látex
- Suporte para árvores de carvalho
- Sistema de cooldown por árvore
- Verificações de inventário e itens
- Blip no mapa para localização do seringal

## 🤝 Contribuição

Sinta-se à vontade para contribuir com o projeto através de pull requests ou reportando issues.

## 📄 Licença

Este projeto está sob a licença KING. Veja o arquivo LICENSE para mais detalhes. 