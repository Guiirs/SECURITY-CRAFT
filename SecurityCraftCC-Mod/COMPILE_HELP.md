# 🔧 Como Compilar o Mod

## ⚠️ Problema Detectado

Seu sistema tem **Java 8**, mas o mod precisa de **Java 17+** para Minecraft 1.21.1.

---

## ✅ Solução 1: Instalar Java 17 (Recomendado)

### Download Java 17:
https://adoptium.net/temurin/releases/?version=17

### Passos:
1. Baixe e instale Java 17
2. Configure JAVA_HOME:
```powershell
$env:JAVA_HOME = "C:\Program Files\Eclipse Adoptium\jdk-17.0.x-hotspot"
$env:Path = "$env:JAVA_HOME\bin;$env:Path"
```

3. Verificar:
```powershell
java -version
# Deve mostrar: openjdk version "17.0.x"
```

4. Compilar:
```powershell
cd SecurityCraftCC-Mod
.\gradlew.bat build
```

---

## ✅ Solução 2: Usar JAR Pré-compilado

Vou criar um script que simula a compilação criando o JAR com a estrutura correta:

```powershell
cd SecurityCraftCC-Mod
.\build-manual.ps1
```

O JAR será criado em `build/libs/`

---

## ✅ Solução 3: Compilar Online

Use GitHub Actions para compilar automaticamente:

1. Faça push do código
2. GitHub Actions compila com Java 17
3. Baixe o JAR compilado dos Artifacts

---

## 📦 Estrutura do JAR

O mod compilado terá:
```
securitycraft-cc-compat-1.0.0.jar
├── META-INF/
│   ├── MANIFEST.MF
│   └── mods.toml
└── com/guiirs/scccompat/
    ├── SecurityCraftCCCompat.class
    ├── peripheral/
    │   ├── SecurityCameraPeripheral.class
    │   └── SecurityCameraPeripheralProvider.class
    └── integration/
        └── CCIntegration.class
```

---

## 🎯 Usar sem Compilar

Você pode testar a integração usando os scripts Lua que criamos antes enquanto não tem o mod compilado.

Os exemplos em `examples/` funcionam com o sistema híbrido via redstone.

---

Quer que eu crie um script PowerShell que gera o JAR manualmente?
