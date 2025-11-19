# SecurityCraft CC:Tweaked Compatibility Mod

![Minecraft](https://img.shields.io/badge/Minecraft-1.19.2-green)
![Forge](https://img.shields.io/badge/Forge-43.3.0-orange)
![License](https://img.shields.io/badge/License-MIT-blue)

**Mod que torna Security Cameras do SecurityCraft compatíveis com CC:Tweaked!**

Conecte câmeras diretamente aos computadores e acesse feeds programaticamente via Lua.

---

## 🎯 O Que Este Mod Faz

Este mod adiciona integração completa entre **SecurityCraft** e **CC:Tweaked**:

✅ **Security Cameras** aparecem como periféricos CC  
✅ **Conexão direta** via Networking Cable  
✅ **API Lua completa** para controle programático  
✅ **Captura de dados** em tempo real  
✅ **Detecção de movimento** automática  
✅ **Scan de entidades** no campo de visão  

---

## 📋 Requisitos

### Mods Necessários:
- **Minecraft**: 1.19.2 ou superior
- **Forge**: 43.3.0 ou superior
- **SecurityCraft**: 1.9.7 ou superior
- **CC:Tweaked**: 1.101.0 ou superior

---

## 📥 Instalação

### Método 1: Download Pré-compilado
1. Baixe o JAR da [página de Releases](https://github.com/Guiirs/SECURITY-CRAFT/releases)
2. Coloque o arquivo `.jar` na pasta `mods/`
3. Certifique-se que SecurityCraft e CC:Tweaked também estão instalados
4. Inicie o Minecraft

### Método 2: Compilar do Source
```bash
git clone https://github.com/Guiirs/SECURITY-CRAFT.git
cd SecurityCraftCC-Mod
./gradlew build
```
O JAR compilado estará em `build/libs/`

---

## 🎮 Como Usar

### Passo 1: Conectar Hardware
```
[Security Camera] --- [Networking Cable] --- [Computer]
                                                 |
                                            [Monitor]
```

### Passo 2: Código Básico
```lua
-- Encontrar câmera
local camera = peripheral.find("security_camera")

-- Obter informações
local info = camera.getInfo()
print("Camera: " .. info.id)
print("Posição: " .. info.x .. ", " .. info.y .. ", " .. info.z)

-- Capturar dados
local capture = camera.capture()
print("Entidades detectadas: " .. capture.entityCount)
```

---

## 📚 API Lua Completa

### Métodos Disponíveis:

#### `getInfo()` → table
Retorna informações básicas da câmera:
```lua
{
    id = "camera_100_64_200",
    x = 100, y = 64, z = 200,
    active = true,
    yaw = 0.0, pitch = 0.0,
    viewDistance = 32
}
```

#### `isActive()` → boolean
Verifica se a câmera está ativa.

#### `setActive(active)` → boolean
Liga/desliga a câmera.

#### `getPosition()` → table
Retorna coordenadas x, y, z.

#### `getRotation()` → table
Retorna rotação atual (yaw, pitch).

#### `setRotation(yaw, pitch)` → boolean
Define rotação da câmera (-180 a 180, -90 a 90).

#### `getViewDistance()` → number
Retorna distância de visão em blocos.

#### `setViewDistance(distance)` → boolean
Define distância de visão (1-64 blocos).

#### `capture()` → table
Captura dados atuais da câmera:
```lua
{
    timestamp = 1234567890,
    position = {x, y, z},
    rotation = {yaw, pitch},
    entities = {{...}},
    entityCount = 2,
    motionDetected = true
}
```

#### `scanEntities()` → table
Retorna lista de entidades detectadas:
```lua
{
    {
        type = "minecraft:player",
        name = "Steve",
        x = 105.2, y = 64.0, z = 201.5,
        distance = 8.3,
        isPlayer = true
    },
    ...
}
```

#### `detectMotion()` → boolean
Detecta se há movimento no campo de visão.

#### `getLightLevel()` → number
Retorna nível de luz na câmera (0-15).

#### `getTimeOfDay()` → string
Retorna "day", "night" ou "unknown".

#### `getStatus()` → table
Retorna status completo do sistema:
```lua
{
    online = true,
    position = {...},
    rotation = {...},
    viewDistance = 32,
    lightLevel = 15,
    timeOfDay = "day",
    entitiesInView = 2,
    motionDetected = true
}
```

#### `reset()` → boolean
Reseta câmera para configurações padrão.

---

## 💡 Exemplos Práticos

### Sistema de Vigilância Simples
```lua
local camera = peripheral.find("security_camera")
local monitor = peripheral.find("monitor")

while true do
    local capture = camera.capture()
    
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("Entidades: " .. capture.entityCount)
    
    if capture.motionDetected then
        monitor.write(" [MOVIMENTO!]")
    end
    
    sleep(1)
end
```

### Alarme de Segurança
```lua
local camera = peripheral.find("security_camera")

while true do
    local entities = camera.scanEntities()
    
    for _, entity in ipairs(entities) do
        if entity.isPlayer then
            print("ALERTA: Jogador detectado - " .. entity.name)
            redstone.setOutput("back", true)
            sleep(5)
            redstone.setOutput("back", false)
        end
    end
    
    sleep(0.5)
end
```

### Múltiplas Câmeras
```lua
local cameras = {peripheral.find("security_camera")}
print("Encontradas " .. #cameras .. " cameras")

for i, cam in ipairs(cameras) do
    local info = cam.getInfo()
    local status = cam.getStatus()
    print("Camera " .. i .. ": " .. status.entitiesInView .. " entidades")
end
```

---

## 📁 Exemplos Incluídos

O mod inclui 4 programas exemplo completos:

1. **01_basic.lua** - Uso básico da API
2. **02_surveillance.lua** - Sistema de vigilância com monitor
3. **03_multi_camera.lua** - Gerenciamento de múltiplas câmeras
4. **04_alarm_system.lua** - Sistema de alarme com detecção

Encontre-os na pasta `examples/` do repositório.

---

## 🔧 Compilação

### Requisitos de Build:
- Java 17+
- Gradle 7.6+

### Comandos:
```bash
# Compilar
./gradlew build

# Executar cliente de desenvolvimento
./gradlew runClient

# Executar servidor de desenvolvimento
./gradlew runServer
```

---

## 🐛 Troubleshooting

### "Peripheral não encontrado"
- Verifique se a Security Camera está conectada via Networking Cable
- Execute `peripherals` no computador para listar dispositivos
- Certifique-se que o mod está instalado corretamente

### "Erro ao capturar"
- Verifique se a câmera está ativa: `camera.isActive()`
- Tente reativar: `camera.setActive(true)`

### "Mod não carrega"
- Verifique se todos os mods dependentes estão instalados
- Cheque o log do Minecraft em `logs/latest.log`
- Certifique-se da compatibilidade de versões

---

## 🤝 Contribuindo

Contribuições são bem-vindas!

1. Fork o projeto
2. Crie uma branch para sua feature
3. Commit suas mudanças
4. Push para a branch
5. Abra um Pull Request

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja [LICENSE](../LICENSE) para detalhes.

---

## 🔗 Links

- **Repositório**: https://github.com/Guiirs/SECURITY-CRAFT
- **Issues**: https://github.com/Guiirs/SECURITY-CRAFT/issues
- **SecurityCraft**: https://www.curseforge.com/minecraft/mc-mods/security-craft
- **CC:Tweaked**: https://www.curseforge.com/minecraft/mc-mods/cc-tweaked

---

## 📝 Changelog

### v1.0.0 (2025-11-19)
- ✨ Release inicial
- ✅ Suporte completo para Security Cameras como periféricos
- ✅ API Lua com 15+ métodos
- ✅ Detecção de movimento e scan de entidades
- ✅ 4 exemplos de código incluídos

---

**Desenvolvido por Guiirs**  
*Tornando SecurityCraft e CC:Tweaked compatíveis!* 🚀
