# Building SecurityCraft CC:Tweaked Compatibility Mod

## Prerequisites

### Required Software:
- **Java Development Kit (JDK) 17 or higher**
  - Download: https://adoptium.net/
  - Verify: `java -version`

- **Git**
  - Download: https://git-scm.com/
  - Verify: `git --version`

### Required Minecraft Mods (for runtime):
- SecurityCraft 1.9.7+ (place in `libs/` folder for compilation)
- CC:Tweaked 1.101.0+ (automatically downloaded by Gradle)

---

## Step-by-Step Build Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/Guiirs/SECURITY-CRAFT.git
cd SECURITY-CRAFT/SecurityCraftCC-Mod
```

### 2. Download SecurityCraft JAR
Since SecurityCraft is not available in Maven repositories, you need to manually download it:

1. Go to [SecurityCraft CurseForge](https://www.curseforge.com/minecraft/mc-mods/security-craft)
2. Download the JAR for Minecraft 1.19.2
3. Create a `libs/` folder in the mod directory
4. Place the SecurityCraft JAR in `libs/`
5. Rename it to `securitycraft-1.19.2.jar`

```bash
mkdir libs
# Place SecurityCraft JAR here
```

### 3. Setup Gradle Wrapper (Windows)
```powershell
# If gradlew.bat doesn't exist, you'll need Gradle installed
# Download from: https://gradle.org/install/

# Then generate wrapper:
gradle wrapper
```

### 4. Build the Mod
```powershell
# Windows
.\gradlew.bat build

# Linux/Mac
./gradlew build
```

This will:
- Download dependencies (CC:Tweaked, Forge, etc.)
- Compile Java sources
- Generate the mod JAR

### 5. Find the Built JAR
```
build/libs/securitycraft-cc-compat-1.0.0.jar
```

---

## Development Setup

### Setup IDE (IntelliJ IDEA recommended)

#### Option 1: IntelliJ IDEA
```powershell
.\gradlew.bat genIntellijRuns
```
Then open the project in IntelliJ IDEA.

#### Option 2: Eclipse
```powershell
.\gradlew.bat genEclipseRuns
.\gradlew.bat eclipse
```
Then import the project in Eclipse.

### Run Development Client
```powershell
.\gradlew.bat runClient
```

### Run Development Server
```powershell
.\gradlew.bat runServer
```

---

## Troubleshooting

### "Could not find securitycraft JAR"
**Solution**: Make sure SecurityCraft JAR is in `libs/` folder:
```
libs/
  └── securitycraft-1.19.2.jar
```

### "Java version error"
**Solution**: Install Java 17:
```powershell
# Check current version
java -version

# Download Java 17 from https://adoptium.net/
```

### "Permission denied" (Linux/Mac)
**Solution**: Make gradlew executable:
```bash
chmod +x gradlew
```

### "Out of memory" during build
**Solution**: Increase Gradle memory in `gradle.properties`:
```properties
org.gradle.jvmargs=-Xmx4G
```

---

## Testing the Mod

### Manual Testing:
1. Build the mod
2. Copy JAR to Minecraft `mods/` folder
3. Ensure SecurityCraft and CC:Tweaked are also installed
4. Launch Minecraft
5. Create a world and place:
   - Security Camera (SecurityCraft)
   - Computer (CC:Tweaked)
   - Networking Cable (CC:Tweaked)
6. Connect them and run:
```lua
peripherals  -- Should list "security_camera"
```

### Log Checking:
Check `logs/latest.log` for:
```
[scccompat] SecurityCraft CC:Tweaked Compatibility Mod Loading...
[scccompat] Registering SecurityCraft cameras as CC:Tweaked peripherals...
[scccompat] SecurityCraft CC:Tweaked Compatibility initialized!
```

---

## Clean Build

If you encounter issues, clean and rebuild:
```powershell
.\gradlew.bat clean
.\gradlew.bat build --refresh-dependencies
```

---

## Publishing

### Create a Release:
```powershell
# Build production JAR
.\gradlew.bat build

# JAR will be in build/libs/
```

### Upload to:
- **CurseForge**: https://www.curseforge.com/minecraft/mc-mods
- **Modrinth**: https://modrinth.com/
- **GitHub Releases**: https://github.com/Guiirs/SECURITY-CRAFT/releases

---

## Additional Resources

- **Forge Documentation**: https://docs.minecraftforge.net/
- **CC:Tweaked API**: https://tweaked.cc/
- **SecurityCraft Wiki**: https://wiki.securitycraft.org/

---

**Build tested on:**
- Windows 11
- Java 17.0.9
- Gradle 7.6
- Forge 43.3.0
- Minecraft 1.19.2
