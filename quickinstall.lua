-- Quick Install - SecurityCraft Camera Monitor
-- Instalador compacto de uma linha

local function download(file)
    local url = "https://raw.githubusercontent.com/Guiirs/SECURITY-CRAFT/master/" .. file
    local response = http.get(url)
    if response then
        local content = response.readAll()
        response.close()
        local f = fs.open(file, "w")
        f.write(content)
        f.close()
        return true
    end
    return false
end

print("SecurityCraft Camera Monitor - Quick Install")
print("Baixando arquivos...")

local files = {"camera_monitor.lua", "camera_grid.lua", "camera_advanced.lua"}
local ok = 0

for _, file in ipairs(files) do
    if download(file) then
        print("OK: " .. file)
        ok = ok + 1
    else
        print("ERRO: " .. file)
    end
end

print("\nInstalados: " .. ok .. "/" .. #files)
print("\nExecute: camera_monitor")
