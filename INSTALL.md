# 🎮 Instalação no ComputerCraft

## 📥 Método 1: Instalador Automático (Recomendado)

### No computador do Minecraft, digite:

```lua
pastebin put installer
```

Depois use o código do Pastebin:

```lua
pastebin get <CODIGO> install
install
```

---

## 📥 Método 2: Download Direto via GitHub

### Passo 1: Habilitar HTTP API

Edite o arquivo `config/computercraft-common.toml`:
```toml
[http]
    enabled = true
    allowed = ["*"]
```

### Passo 2: No computador do Minecraft

```lua
-- Baixar instalador
wget https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/installer.lua
installer
```

Ou baixar programas individuais:

```lua
-- Monitor Simples
wget https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/camera_monitor.lua

-- Grade de Câmeras
wget https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/camera_grid.lua

-- Sistema Avançado
wget https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/camera_advanced.lua
```

---

## 📥 Método 3: Instalação Manual

### Passo 1: Baixar arquivos do GitHub
Vá para: https://github.com/Guiirs/SECURITY-CRAFT

### Passo 2: Copiar para pasta do mundo
```
saves/[NomeMundo]/computercraft/computer/[ID]/
```

Copie os arquivos `.lua` para esta pasta.

### Passo 3: Executar no jogo
```lua
camera_monitor
```

---

## 📥 Método 4: Código Único (Uma Linha)

```lua
wget run https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/quickinstall.lua
```

---

## 🔧 Comandos Rápidos

### Instalar tudo:
```lua
wget https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/installer.lua
installer
```

### Executar programa:
```lua
camera_monitor    -- Sistema básico
camera_grid       -- Grade múltipla
camera_advanced   -- Sistema completo
```

### Atualizar:
```lua
delete camera_monitor.lua
delete camera_grid.lua
delete camera_advanced.lua
wget run https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/installer.lua
```

---

## ⚡ Instalação Super Rápida

### Cole no computador CC:
```lua
local function d(f) local r=http.get("https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/"..f) if r then local c=r.readAll() r.close() local h=fs.open(f,"w") h.write(c) h.close() return true end return false end for _,f in ipairs({"camera_monitor.lua","camera_grid.lua","camera_advanced.lua"}) do if d(f) then print("OK: "..f) end end print("Instalado! Execute: camera_monitor")
```

---

## ❓ Troubleshooting

### "HTTP API desabilitada"
Edite `config/computercraft-common.toml` e mude:
```toml
[http]
    enabled = true
```

### "Não consegue conectar ao GitHub"
1. Verifique internet no servidor
2. Adicione GitHub na whitelist:
```toml
[http]
    allowed = ["*"]
```

### "Arquivo não encontrado"
Verifique se o URL está correto:
```
https://github.com/Guiirs/SECURITY-CRAFT
```

---

## 📋 Verificar Instalação

```lua
list  -- Ver arquivos instalados
```

Deve mostrar:
- `camera_monitor.lua`
- `camera_grid.lua`
- `camera_advanced.lua`

---

## 🎯 Após Instalação

1. **Conecte o hardware**:
   - Monitor ao computador
   - Câmeras via cabo de rede

2. **Execute o programa**:
   ```lua
   camera_monitor
   ```

3. **Controles**:
   - `←` `→` - Navegar
   - `Q` - Sair

---

## 🔗 Links Úteis

- **Repositório**: https://github.com/Guiirs/SECURITY-CRAFT
- **Issues**: https://github.com/Guiirs/SECURITY-CRAFT/issues
- **Releases**: https://github.com/Guiirs/SECURITY-CRAFT/releases

---

**Desenvolvido para ComputerCraft: Tweaked + SecurityCraft**
