# ⚠️ Solução: SecurityCraft Câmeras não conectam diretamente

## Problema

As **Security Cameras** do SecurityCraft **NÃO são periféricos** do ComputerCraft e não podem ser conectadas diretamente via Networking Cable.

## ✅ Soluções Disponíveis

### 🔴 Opção 1: Usar Security Monitor (Recomendado)

O SecurityCraft tem seu próprio sistema de monitoramento:

**Hardware necessário:**
- Security Camera (SecurityCraft)
- Security Monitor (SecurityCraft) 
- Monitor (CC:Tweaked)
- Computer (CC:Tweaked)

**Como funciona:**
1. Coloque Security Cameras onde quiser
2. Use Security Monitor para vincular às câmeras
3. Use o CC:Tweaked para controlar QUAL câmera visualizar
4. O Security Monitor mostra o feed real

**Programas criados:**
- `camera_controller.lua` - Controla seleção de câmeras
- Lista e organiza suas câmeras
- Interface de navegação

---

### 🔴 Opção 2: Controle via Redstone

Use **Redstone** para alternar entre câmeras:

**Setup:**
```
[Computer] --redstone--> [Security Monitor] --> [Camera Feed]
```

**Como configurar:**

1. Edite `camera_redstone.lua`:
```lua
local cameras = {
    {
        id = 1,
        name = "Entrada",
        redstoneOutput = "left",  -- Lado do redstone
    },
    {
        id = 2,
        name = "Cofre",
        redstoneOutput = "right",
    }
}
```

2. Conecte redstone do computador aos Security Monitors
3. Execute `camera_redstone`
4. Use setas para selecionar câmera
5. Pressione Enter para ativar via redstone

---

### 🔴 Opção 3: Sistema de Listagem e Coordenadas

Se não precisa do feed visual, apenas organizar:

**Programa:** `camera_controller.lua`

**Configure suas câmeras:**
```lua
local cameras = {
    {id = 1, name = "Entrada Principal", x = 100, y = 64, z = 200},
    {id = 2, name = "Cofre", x = 95, y = 64, z = 195},
    {id = 3, name = "Corredor", x = 105, y = 64, z = 205},
}
```

**Funcionalidades:**
- Lista todas as câmeras
- Mostra localização de cada uma
- Navegação entre câmeras
- Sistema de "gravação" simulado
- Interface profissional

---

### 🔴 Opção 4: Integração com OpenSecurity (Mod Adicional)

Se puder adicionar mods:

**Mod:** [OpenSecurity](https://www.curseforge.com/minecraft/mc-mods/opensecurity)

Este mod adiciona câmeras que **SÃO** periféricos do CC:Tweaked!

**Vantagens:**
- Conexão direta via cabo
- Feed real no monitor CC
- API completa para programação

**Desvantagem:**
- Requer mod adicional

---

## 🎯 Qual Usar?

| Método | Dificuldade | Feed Real | Mods Extras |
|--------|-------------|-----------|-------------|
| Security Monitor | ⭐⭐ Média | ✅ Sim | ❌ Não |
| Controle Redstone | ⭐⭐⭐ Difícil | ✅ Sim | ❌ Não |
| Listagem/Info | ⭐ Fácil | ❌ Não | ❌ Não |
| OpenSecurity | ⭐ Fácil | ✅ Sim | ⚠️ Sim |

---

## 📥 Instalação dos Novos Programas

### No CC:Tweaked:

```lua
# Controlador de câmeras
wget https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/camera_controller.lua

# Sistema com redstone
wget https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/camera_redstone.lua
```

### Executar:
```lua
camera_controller  -- Sistema de listagem
camera_redstone    -- Controle via redstone
```

---

## 🔧 Tutorial Completo: Setup com Security Monitor

### Passo 1: Hardware SecurityCraft
1. Coloque **Security Cameras** nas áreas
2. Coloque **Security Monitor** onde quiser visualizar
3. Clique direito no Security Monitor
4. Vincule às câmeras (botão "Add Camera")

### Passo 2: Hardware CC:Tweaked
1. Coloque **Computer**
2. Conecte **Monitor** ao computer
3. (Opcional) Adicione **Redstone** para controle

### Passo 3: Software
```lua
wget https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/camera_controller.lua
edit camera_controller
```

Configure suas câmeras no código:
```lua
local cameras = {
    {id = 1, name = "Sua Camera 1", x = 100, y = 64, z = 200},
    {id = 2, name = "Sua Camera 2", x = 95, y = 64, z = 195},
}
```

### Passo 4: Executar
```lua
camera_controller
```

---

## 🆘 FAQ

**P: Por que não consigo conectar a câmera?**
R: Security Cameras não são periféricos CC. Use Security Monitor.

**P: Tem como ver o feed no monitor CC?**
R: Não diretamente. Use OpenSecurity mod ou Security Monitor.

**P: O redstone pode controlar as câmeras?**
R: Sim! Use `camera_redstone.lua` para alternar entre elas.

**P: Vale a pena adicionar OpenSecurity?**
R: Se quiser integração total CC + câmeras, sim!

---

## 🔗 Links Úteis

- [SecurityCraft Wiki](https://wiki.securitycraft.org/)
- [CC:Tweaked Docs](https://tweaked.cc/)
- [OpenSecurity Mod](https://www.curseforge.com/minecraft/mc-mods/opensecurity)

---

**Programas originais ainda funcionam como sistemas de interface/controle!**
