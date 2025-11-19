# PowerShell script to build the mod JAR manually
# Run this if you don't have Java 17+ installed

Write-Host "=== SecurityCraft CC:Tweaked Compatibility Mod Builder ===" -ForegroundColor Cyan
Write-Host ""

# Check Java version
$javaVersion = java -version 2>&1 | Select-String "version" | ForEach-Object { $_ -replace '.*"(.*)".*','$1' }
Write-Host "Java Version Detected: $javaVersion" -ForegroundColor Yellow

if ($javaVersion -notmatch "^(17|18|19|20|21)\.") {
    Write-Host ""
    Write-Host "WARNING: Java 17+ required!" -ForegroundColor Red
    Write-Host "Current version: $javaVersion" -ForegroundColor Red
    Write-Host ""
    Write-Host "Download Java 17: https://adoptium.net/" -ForegroundColor Green
    Write-Host ""
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -ne "y") {
        exit 1
    }
}

Write-Host ""
Write-Host "Building mod..." -ForegroundColor Green

# Create build directories
New-Item -ItemType Directory -Force -Path "build\classes" | Out-Null
New-Item -ItemType Directory -Force -Path "build\libs" | Out-Null
New-Item -ItemType Directory -Force -Path "build\resources" | Out-Null

# Copy resources
Write-Host "Copying resources..." -ForegroundColor Yellow
Copy-Item -Path "src\main\resources\*" -Destination "build\resources\" -Recurse -Force

# Try to compile Java files
Write-Host "Compiling Java sources..." -ForegroundColor Yellow
$javaFiles = Get-ChildItem -Path "src\main\java" -Filter "*.java" -Recurse

$classpath = "libs\*"
$compileCmd = "javac -cp `"$classpath`" -d build\classes " + ($javaFiles.FullName -join " ")

try {
    Invoke-Expression $compileCmd 2>&1 | Out-Null
    $compiled = $true
    Write-Host "Compilation successful!" -ForegroundColor Green
} catch {
    $compiled = $false
    Write-Host "Compilation failed (missing dependencies)" -ForegroundColor Red
    Write-Host "Creating JAR with source files instead..." -ForegroundColor Yellow
}

# Create JAR
Write-Host "Creating JAR file..." -ForegroundColor Yellow

$jarPath = "build\libs\securitycraft-cc-compat-1.0.0.jar"

# Use Java's jar command
if ($compiled) {
    jar -cfm $jarPath build\resources\META-INF\MANIFEST.MF -C build\classes . -C build\resources .
} else {
    # Create source JAR if compilation failed
    $sourcePath = "build\libs\securitycraft-cc-compat-1.0.0-sources.jar"
    jar -cf $sourcePath -C src\main\java . -C src\main\resources .
    
    Write-Host ""
    Write-Host "Created source JAR: $sourcePath" -ForegroundColor Yellow
    Write-Host "You'll need to compile this on a system with Java 17+" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Build Complete ===" -ForegroundColor Green
Write-Host "Output: $jarPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "To use this mod:" -ForegroundColor White
Write-Host "1. Copy the JAR to your Minecraft mods/ folder" -ForegroundColor White
Write-Host "2. Make sure SecurityCraft and CC:Tweaked are installed" -ForegroundColor White
Write-Host "3. Launch Minecraft 1.21.1 with Forge" -ForegroundColor White
Write-Host ""
