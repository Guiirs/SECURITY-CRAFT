# 📹 SecurityCraft Camera Monitor for CC:Tweaked

Sistema completo de monitoramento que integra câmeras do **SecurityCraft** com monitores do **ComputerCraft: Tweaked** para Minecraft.

![Minecraft](https://img.shields.io/badge/Minecraft-1.12--1.20+-brightgreen)
![CC:Tweaked](https://img.shields.io/badge/CC%3ATweaked-Required-blue)
![SecurityCraft](https://img.shields.io/badge/SecurityCraft-Required-red)
![License](https://img.shields.io/badge/License-MIT-yellow)

## 🎮 Funcionalidades

- ✅ Visualização de câmeras SecurityCraft em monitores CC:Tweaked
- ✅ Suporte para múltiplas câmeras
- ✅ 3 modos de visualização diferentes
- ✅ Interface gráfica intuitiva
- ✅ Sistema de navegação entre câmeras
- ✅ Detecção automática de dispositivos
- ✅ Sistema de gravação simulado
- ✅ Grade de múltiplas câmeras

## 📋 Requisitos

### Mods Necessários
- [ComputerCraft: Tweaked](https://www.curseforge.com/minecraft/mc-mods/cc-tweaked)
- [SecurityCraft](https://www.curseforge.com/minecraft/mc-mods/security-craft)

### Hardware in-game
- 1x Computer ou Advanced Computer
- 1x Monitor ou Advanced Monitor (pode combinar vários)
- Nx Security Cameras
- Networking Cables (cabos de rede)

## 🚀 Instalação

### Método 1: Manual (In-game)
```lua
-- No computador do Minecraft:
pastebin get <code> camera_monitor
camera_monitor
```

### Método 2: Arquivo Direto
1. Clone este repositório
2. Copie os arquivos `.lua` para a pasta do mundo:
   ```
   saves/[seu-mundo]/computercraft/computer/[id-do-computador]/
   ```
3. Execute no computador in-game

### Método 3: HTTPs (se habilitado)
```lua
wget https://raw.githubusercontent.com/[seu-usuario]/[repo]/main/camera_monitor.lua
camera_monitor
```

## 📦 Arquivos do Projeto

| Arquivo | Descrição |
|---------|-----------|
| `camera_monitor.lua` | Sistema básico - uma câmera por vez |
| `camera_grid.lua` | Grade com múltiplas câmeras |
| `camera_advanced.lua` | Sistema profissional completo |
| `README.md` | Documentação detalhada |

## 🔧 Configuração

### Passo 1: Hardware Setup
```
[Security Camera] ─── [Networking Cable] ─── [Computer]
                                                  │
                                             [Monitor]
```

### Passo 2: Executar Programa
```lua
-- Escolha um dos programas:
camera_monitor    -- Modo simples
camera_grid       -- Modo grade
camera_advanced   -- Modo avançado
```

## 🎯 Uso

### camera_monitor.lua
**Sistema básico de visualização**
- `←` `→` - Trocar entre câmeras
- `Q` - Sair

### camera_grid.lua
**Grade de múltiplas câmeras**
- Atualização automática
- `Q` - Sair

### camera_advanced.lua
**Sistema profissional**
- `←` `→` - Navegar câmeras
- `R` - Gravar
- `S` - Escanear novas câmeras
- `A` - Ver alertas
- `Q` - Sair

## 🖼️ Screenshots

```
╔═══════════════════════════════════╗
║  SISTEMA DE SEGURANCA - Camera 1  ║
╠═══════════════════════════════════╣
║                                   ║
║        [FEED DE VÍDEO]            ║
║                                   ║
╠═══════════════════════════════════╣
║ [<][>] Trocar  [R] Gravar  [Q] Sair
╚═══════════════════════════════════╝
```

## 🔌 Conexão de Rede

### Rede Simples
```
Camera 1 ──┐
Camera 2 ──┼── Computer ── Monitor
Camera 3 ──┘
```

### Rede com Modem
```
Camera ── Computer ~~~wireless~~~ Central Computer ── Monitor
```

## 🛠️ Personalização

### Alterar velocidade de atualização
```lua
-- Em camera_advanced.lua, linha ~15
updateInterval = 1, -- segundos (padrão: 1)
```

### Mudar escala do texto
```lua
monitor.setTextScale(0.5) -- Opções: 0.5, 1, 1.5, 2
```

### Cores personalizadas
```lua
monitor.setTextColor(colors.lime)    -- Verde
monitor.setBackgroundColor(colors.black)
```

## 🐛 Troubleshooting

| Problema | Solução |
|----------|---------|
| "Monitor não encontrado" | Conecte o monitor ao computador |
| "Câmera não detectada" | Use cabos de rede (Networking Cable) |
| Display cortado | Ajuste `setTextScale()` ou use monitor maior |
| Lag | Reduza número de câmeras ou aumente `updateInterval` |

### Comandos úteis
```lua
peripherals        -- Lista dispositivos conectados
monitor left test  -- Testa monitor
reboot            -- Reinicia computador
```

## 📚 API Reference

### Funções Principais
```lua
scanCameras()      -- Escaneia câmeras conectadas
drawInterface()    -- Atualiza display
handleInput()      -- Processa comandos
```

### Estrutura de Câmera
```lua
{
    id = 1,
    name = "camera_0",
    peripheral = wrapped_peripheral,
    status = "online"
}
```

## 🤝 Contribuindo

Contribuições são bem-vindas!

1. Fork o projeto
2. Crie uma branch (`git checkout -b feature/NovaFuncionalidade`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/NovaFuncionalidade`)
5. Abra um Pull Request

## 📝 Changelog

### v1.0.0 (2025-11-19)
- ✨ Release inicial
- ✅ 3 modos de visualização
- ✅ Detecção automática de câmeras
- ✅ Interface gráfica completa

## 🔮 Roadmap

- [ ] Detecção de movimento real
- [ ] Gravação de eventos em disco
- [ ] Integração com Redstone
- [ ] Sistema de alarme automático
- [ ] Suporte a touchscreen (Advanced Monitor)
- [ ] Multi-monitor sincronizado
- [ ] Replay de gravações

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👥 Autores

Desenvolvido para a comunidade Minecraft

## 🙏 Agradecimentos

- [CC:Tweaked](https://tweaked.cc/) - API do ComputerCraft
- [SecurityCraft](https://security-craft.com/) - Mod de segurança
- Comunidade Minecraft modding

## 📞 Suporte

- **Issues**: [GitHub Issues](https://github.com/[seu-usuario]/[repo]/issues)
- **Discord**: [Servidor da Comunidade]
- **Wiki**: [Documentação Completa]

---

**⭐ Se este projeto foi útil, deixe uma estrela no GitHub!**

Made with ❤️ for Minecraft
