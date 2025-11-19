-- Instalador Automático - SecurityCraft Camera Monitor
-- Execute este arquivo para baixar e instalar o sistema completo

local GITHUB_USER = "Guiirs"
local REPO_NAME = "SECURITY-CRAFT"
local BRANCH = "master"

local files = {
    {name = "camera_monitor.lua", desc = "Monitor Simples"},
    {name = "camera_grid.lua", desc = "Grade de Cameras"},
    {name = "camera_advanced.lua", desc = "Sistema Avancado"}
}

local BASE_URL = "https://raw.githubusercontent.com/" .. GITHUB_USER .. "/" .. REPO_NAME .. "/" .. BRANCH .. "/"

print("===========================================")
print("  INSTALADOR - SecurityCraft Camera System")
print("===========================================")
print("")
print("Repositorio: " .. GITHUB_USER .. "/" .. REPO_NAME)
print("")

-- Função para baixar arquivo
local function downloadFile(filename, url)
    print("Baixando: " .. filename .. "...")
    
    local response = http.get(url)
    
    if response then
        local content = response.readAll()
        response.close()
        
        local file = fs.open(filename, "w")
        file.write(content)
        file.close()
        
        print("  [OK] " .. filename .. " instalado!")
        return true
    else
        print("  [ERRO] Falha ao baixar " .. filename)
        return false
    end
end

-- Verificar se HTTP está habilitado
if not http then
    print("[ERRO] HTTP API desabilitada!")
    print("")
    print("Para habilitar:")
    print("1. Abra: config/computercraft-common.toml")
    print("2. Mude 'http.enabled' para 'true'")
    print("3. Reinicie o servidor/mundo")
    return
end

print("Instalando arquivos...")
print("")

local success = 0
local total = #files

for _, file in ipairs(files) do
    local url = BASE_URL .. file.name
    if downloadFile(file.name, url) then
        success = success + 1
    end
    sleep(0.5)
end

print("")
print("===========================================")
print("  Instalacao Concluida!")
print("===========================================")
print("")
print("Arquivos instalados: " .. success .. "/" .. total)
print("")

if success > 0 then
    print("Programas disponiveis:")
    print("")
    for _, file in ipairs(files) do
        if fs.exists(file.name) then
            print("  - " .. file.name:gsub(".lua", "") .. "  (" .. file.desc .. ")")
        end
    end
    print("")
    print("Execute qualquer um digitando o nome!")
    print("Exemplo: camera_monitor")
else
    print("Nenhum arquivo foi instalado.")
    print("Verifique sua conexao e tente novamente.")
end

print("")
print("Pressione qualquer tecla para sair...")
os.pullEvent("key")
