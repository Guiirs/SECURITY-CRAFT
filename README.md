# Sistema de Monitoramento SecurityCraft + CC:Tweaked

Este projeto integra câmeras do mod SecurityCraft com monitores do ComputerCraft (CC:Tweaked) para criar um sistema completo de vigilância.

## 📋 Requisitos

### Mods Necessários:
- **ComputerCraft: Tweaked** (ou CC: Tweaked)
- **SecurityCraft**

### Hardware do Minecraft:
- 1x Computador (Computer ou Advanced Computer)
- 1x Monitor (ou Monitor Avançado) - pode usar múltiplos para monitores maiores
- Nx Security Cameras (SecurityCraft)
- Cabos de rede (Networking Cable) do ComputerCraft para conectar as câmeras

## 🔧 Instalação

### Passo 1: Configurar Hardware
1. Coloque o computador
2. Conecte o monitor ao computador (lado ou atrás)
3. Coloque as Security Cameras onde deseja monitorar
4. Conecte cada câmera ao computador usando Networking Cables (cabos de rede)

### Passo 2: Carregar o Programa
Existem 3 versões disponíveis:

#### Opção 1: Monitor Simples (`camera_monitor.lua`)
```lua
-- No computador do Minecraft, digite:
edit camera_monitor
-- Cole o código e salve (Ctrl)
camera_monitor
```

#### Opção 2: Grade de Câmeras (`camera_grid.lua`)
```lua
edit camera_grid
-- Cole o código e salve
camera_grid
```

#### Opção 3: Sistema Avançado (`camera_advanced.lua`)
```lua
edit camera_advanced
-- Cole o código e salve
camera_advanced
```

## 🎮 Como Usar

### camera_monitor.lua
**Sistema básico de visualização de câmeras**
- Exibe uma câmera por vez
- Use **Setas Direita/Esquerda** para trocar entre câmeras
- Pressione **Q** para sair

### camera_grid.lua
**Sistema de grade com múltiplas câmeras**
- Mostra todas as câmeras simultaneamente em uma grade
- Atualiza automaticamente a cada 2 segundos
- Pressione **Q** para sair

### camera_advanced.lua
**Sistema profissional completo**
- Interface gráfica avançada
- Controles:
  - **< / >**: Navegar entre câmeras
  - **R**: Iniciar/pausar gravação
  - **S**: Escanear novas câmeras
  - **A**: Ver alertas
  - **Q**: Sair do sistema

## 🔌 Conexão das Câmeras

### Método 1: Cabo Direto
```
[Security Camera] --- [Networking Cable] --- [Computador]
```

### Método 2: Rede Compartilhada
```
[Camera 1] ---\
              [Networking Cable] --- [Computador]
[Camera 2] ---/                          |
                                    [Monitor]
```

### Método 3: Com Modem Wireless
```
[Camera] --- [Computer com Modem] ~~~wireless~~~ [Computer Central] --- [Monitor]
```

## 📝 Notas Importantes

1. **Periféricos**: O sistema detecta automaticamente câmeras conectadas como periféricos
2. **Monitor**: Pode usar monitores 2x2, 3x3 ou maiores para melhor visualização
3. **Atualização**: O sistema escaneia periodicamente por novas câmeras
4. **Performance**: Mais câmeras = mais processamento. Recomenda-se máximo 9 câmeras por computador

## 🐛 Solução de Problemas

### "Nenhum monitor encontrado"
- Verifique se o monitor está conectado ao computador
- Tente rebootar o computador (`reboot` no terminal)

### "Nenhuma câmera encontrada"
- Certifique-se que as Security Cameras estão conectadas via cabo de rede
- Verifique se os cabos estão conectados corretamente
- Use `peripherals` no terminal para listar dispositivos conectados

### Monitor não exibe corretamente
- Ajuste `setTextScale()` no código (valores: 0.5, 1, 2)
- Use monitores maiores (combine monitores em uma grade)

## 🔄 Personalização

### Alterar intervalo de atualização:
```lua
-- Em camera_advanced.lua, linha ~15
updateInterval = 1, -- Mude para 0.5 (mais rápido) ou 2 (mais lento)
```

### Alterar escala do texto:
```lua
-- Em qualquer arquivo, procure:
monitor.setTextScale(0.5) -- Valores: 0.5, 1, 1.5, 2
```

### Adicionar cores personalizadas:
```lua
-- Exemplo de cores disponíveis:
colors.white, colors.orange, colors.magenta, colors.lightBlue
colors.yellow, colors.lime, colors.pink, colors.gray
colors.lightGray, colors.cyan, colors.purple, colors.blue
colors.brown, colors.green, colors.red, colors.black
```

## 📚 Comandos Úteis do ComputerCraft

```lua
peripherals          -- Lista todos os periféricos conectados
monitor left hello   -- Testa se o monitor funciona
reboot              -- Reinicia o computador
edit <arquivo>      -- Edita um arquivo
list                -- Lista arquivos
delete <arquivo>    -- Deleta um arquivo
```

## 🚀 Recursos Futuros

- [ ] Detecção de movimento real
- [ ] Gravação de eventos
- [ ] Integração com Redstone
- [ ] Sistema de alarme
- [ ] Múltiplos monitores sincronizados
- [ ] Interface touchscreen (Advanced Monitor)

## 📄 Licença

Código livre para uso em servidores de Minecraft. Modifique à vontade!

---

**Desenvolvido para Minecraft com ComputerCraft: Tweaked + SecurityCraft**
