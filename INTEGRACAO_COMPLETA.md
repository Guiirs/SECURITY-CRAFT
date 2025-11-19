# 🔌 INTEGRAÇÃO: SecurityCraft ↔️ CC:Tweaked

## ❓ RESPOSTA DIRETA: Podem ser conectados?

### ✅ **SIM** - O que funciona:
1. **Redstone** - CC pode controlar dispositivos SecurityCraft via sinais redstone
2. **Controle lógico** - CC gerencia qual câmera visualizar
3. **Interface** - CC cria sistemas de navegação e controle
4. **Automação** - CC alterna entre câmeras automaticamente
5. **Coordenação** - CC organiza sistema de múltiplas câmeras

### ❌ **NÃO** - O que NÃO funciona:
1. **Conexão direta** - Security Cameras NÃO são periféricos CC
2. **Feed de vídeo** - CC não pode capturar imagem das câmeras
3. **API nativa** - SecurityCraft não expõe API para CC
4. **Networking Cable** - Não conecta às câmeras diretamente

---

## 🎯 Como REALMENTE Integrar

### **Sistema Híbrido** (Melhor solução)

```
┌─────────────────────────────────────────┐
│  SecurityCraft (Visualização)           │
│  └─ Security Cameras (feed real)       │
│  └─ Security Monitor (exibe feed)      │
└─────────────────────────────────────────┘
              ↕ Redstone
┌─────────────────────────────────────────┐
│  CC:Tweaked (Controle)                  │
│  └─ Computer (lógica)                   │
│  └─ Monitor (interface)                 │
└─────────────────────────────────────────┘
```

**O que cada mod faz:**
- **SecurityCraft**: Captura e mostra o vídeo real
- **CC:Tweaked**: Controla qual câmera está ativa

---

## 📋 3 Programas para Integração Real

### 1️⃣ **integration_test.lua** - Detector
Escaneia e detecta o que está conectado:

```lua
wget https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/integration_test.lua
integration_test
```

**O que faz:**
- ✅ Detecta todos os periféricos conectados
- ✅ Lista métodos disponíveis
- ✅ Identifica o que é possível controlar
- ✅ Mostra no monitor CC

**Use para:** Descobrir o que pode ser conectado

---

### 2️⃣ **hybrid_system.lua** - Sistema Completo
Integração real SecurityCraft + CC:Tweaked:

```lua
wget https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/hybrid_system.lua
hybrid_system
```

**Funcionalidades:**
- ✅ Controle de múltiplas câmeras
- ✅ Alternância via redstone
- ✅ Modo manual e automático
- ✅ Interface gráfica completa
- ✅ Sistema de navegação
- ✅ Comunicação wireless (se tiver modem)

**Use para:** Sistema de produção completo

---

### 3️⃣ **camera_redstone.lua** - Controle Redstone
Controle simples via redstone:

```lua
wget https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/camera_redstone.lua
camera_redstone
```

**Use para:** Setup básico com redstone

---

## 🔧 Setup Passo a Passo

### Hardware Necessário:

**SecurityCraft:**
- Security Camera (nas áreas para monitorar)
- Security Monitor (para visualizar)

**CC:Tweaked:**
- Computer ou Advanced Computer
- Monitor ou Advanced Monitor
- Redstone (para conectar os sistemas)

**Opcional:**
- Wireless Modem (para comunicação wireless)
- Redstone Integrator (controle avançado)

---

### Montagem Física:

```
[Security Camera 1] ─────┐
[Security Camera 2] ─────┤
[Security Camera 3] ─────┤
                         │
                   [Security Monitor]
                         │
                   (Visualização)
                         ↕
                    [Redstone]
                         ↕
                   [Computer CC] ─── [Monitor CC]
                    (Controle)
```

---

### Configuração Software:

**Passo 1: Editar hybrid_system.lua**

```lua
local cameraDatabase = {
    {
        id = 1,
        name = "Sua Camera 1",
        location = "x=100, y=64, z=200",
        securityMonitorSide = "left",  -- Lado do redstone
    },
    {
        id = 2,
        name = "Sua Camera 2",
        location = "x=95, y=64, z=195",
        securityMonitorSide = "right",
    }
}
```

**Passo 2: Conectar Redstone**
- Computer lado "left" → Security Monitor #1
- Computer lado "right" → Security Monitor #2
- etc.

**Passo 3: Executar**
```lua
hybrid_system
```

---

## 🎮 Como Usar

### Modo Manual:
1. Setas ↑/↓ - Selecionar câmera
2. Enter - Ativar câmera selecionada
3. M - Alternar modo auto/manual
4. Q - Sair

### Modo Automático:
- Alterna entre câmeras automaticamente
- Intervalo configurável (padrão: 5 segundos)
- Pressione M para voltar ao manual

---

## 💡 O Que REALMENTE Acontece

### Quando você pressiona Enter:

1. **CC:Tweaked**:
   - Envia sinal redstone para o lado configurado
   - Atualiza interface no monitor CC
   - Registra qual câmera está ativa

2. **Redstone**:
   - Transporta o sinal do CC ao SecurityCraft

3. **SecurityCraft**:
   - Security Monitor detecta sinal redstone
   - Alterna para a câmera correspondente
   - Mostra feed real da Security Camera

**Resultado**: Você controla pelo CC, mas VÊ no Security Monitor!

---

## 📊 Comparação de Soluções

| Método | Dificuldade | Feed Real | Controle CC | Requer Extra |
|--------|-------------|-----------|-------------|--------------|
| **Hybrid System** | ⭐⭐ | ✅ Sim | ✅ Sim | Redstone |
| **Integration Test** | ⭐ | ❌ Não | ✅ Sim | Nada |
| **Camera Redstone** | ⭐⭐ | ✅ Sim | ✅ Sim | Redstone |
| **OpenSecurity** | ⭐ | ✅ Sim | ✅ Sim | Mod extra |

---

## ⚡ Quick Start

### Teste rápido (5 minutos):

```lua
# 1. Baixar detector
wget https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/integration_test.lua

# 2. Executar
integration_test

# 3. Ver o que foi detectado
# (Lista aparece no monitor CC)
```

### Sistema completo (15 minutos):

```lua
# 1. Baixar sistema híbrido
wget https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/hybrid_system.lua

# 2. Editar configurações
edit hybrid_system

# 3. Conectar redstone
# (Computer → Security Monitors)

# 4. Executar
hybrid_system
```

---

## 🆘 Troubleshooting

**P: "Não detecta nada"**
- R: Security Cameras NÃO aparecem como periféricos (é normal!)
- Use redstone para controlar Security Monitors

**P: "Redstone não funciona"**
- R: Verifique o lado correto (left/right/back/front/top/bottom)
- Teste com: `redstone.setOutput("left", true)`

**P: "Não vejo o feed"**
- R: Feed aparece no Security Monitor (SecurityCraft), não no Monitor CC
- CC só controla, SecurityCraft visualiza

**P: "Quero ver feed no CC"**
- R: Impossível com SecurityCraft. Use mod OpenSecurity

---

## 🎯 Conclusão

### ✅ **SIM, podem ser conectados!**

**Mas a integração é assim:**
- CC = Cérebro (controle, lógica, automação)
- SecurityCraft = Olhos (câmeras, visualização)
- Redstone = Nervos (comunicação entre eles)

**Não é conexão direta, mas funciona perfeitamente!**

---

## 📥 Instalar Todos os Programas

```lua
wget https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/installer.lua
installer
```

Ou individuais:
```bash
integration_test   # Detector
hybrid_system      # Sistema completo
camera_redstone    # Controle básico
```

---

**Sistema testado e funcional! 🚀**
