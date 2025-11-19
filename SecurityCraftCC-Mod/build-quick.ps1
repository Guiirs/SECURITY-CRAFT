# Quick JAR Builder - Creates mod structure without full compilation
# Works with any Java version

Write-Host "=== Quick Mod JAR Builder ===" -ForegroundColor Cyan
Write-Host "Creating mod JAR structure..." -ForegroundColor Green
Write-Host ""

# Criar estrutura
$buildDir = "build-quick"
$jarName = "securitycraft-cc-compat-1.0.0-dev.jar"

Remove-Item -Path $buildDir -Recurse -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path "$buildDir\META-INF" -Force | Out-Null
New-Item -ItemType Directory -Path "$buildDir\com\guiirs\scccompat" -Force | Out-Null

# Copiar mods.toml
Copy-Item "src\main\resources\META-INF\mods.toml" "$buildDir\META-INF\" -Force

# Criar MANIFEST.MF
$manifest = @"
Manifest-Version: 1.0
Implementation-Title: SecurityCraft CC:Tweaked Compatibility
Implementation-Version: 1.0.0
Implementation-Vendor: Guiirs
Specification-Title: scccompat
Specification-Version: 1
Specification-Vendor: Guiirs

"@

Set-Content -Path "$buildDir\META-INF\MANIFEST.MF" -Value $manifest

# Copiar sources (para referência)
Copy-Item "src\main\java\*" "$buildDir\" -Recurse -Force

# Criar README dentro do JAR
$readme = @"
SecurityCraft CC:Tweaked Compatibility Mod
Version: 1.0.0-dev

This is a development version.
For full functionality, compile with Java 17+.

Source code included for reference.

Repository: https://github.com/Guiirs/SECURITY-CRAFT
"@

Set-Content -Path "$buildDir\README.txt" -Value $readme

# Criar o JAR
Write-Host "Creating JAR file..." -ForegroundColor Yellow

$jarPath = "build\libs"
New-Item -ItemType Directory -Path $jarPath -Force | Out-Null

# Usar compressão ZIP primeiro, depois renomear
$zipPath = "$jarPath\temp.zip"
$jarFile = "$jarPath\$jarName"

Compress-Archive -Path "$buildDir\*" -DestinationPath $zipPath -Force
Move-Item -Path $zipPath -Destination $jarFile -Force

Write-Host ""
Write-Host "=== JAR Created ===" -ForegroundColor Green
Write-Host "Location: $jarPath\$jarName" -ForegroundColor Cyan
Write-Host ""
Write-Host "NOTE: This is a development JAR with source code." -ForegroundColor Yellow
Write-Host "For a working mod, you need:" -ForegroundColor Yellow
Write-Host "1. Java 17+ installed" -ForegroundColor White
Write-Host "2. Proper compilation with Gradle" -ForegroundColor White
Write-Host ""
Write-Host "Alternative: Use the Lua scripts in examples/ folder" -ForegroundColor Green
Write-Host "They work without this mod using the hybrid system!" -ForegroundColor Green
Write-Host ""

# Cleanup
Remove-Item -Path $buildDir -Recurse -Force
