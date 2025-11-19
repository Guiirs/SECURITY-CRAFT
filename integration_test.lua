-- INTEGRAÇÃO REAL: SecurityCraft + CC:Tweaked
-- Detecta e interage com blocos SecurityCraft usando APIs disponíveis

local monitor = peripheral.find("monitor")

if not monitor then
    error("Monitor não encontrado!")
end

-- Configuração
monitor.setTextScale(0.5)
monitor.setBackgroundColor(colors.black)
local width, height = monitor.getSize()

-- Sistema de detecção de periféricos SecurityCraft
local function scanSecurityCraftDevices()
    local devices = {
        cameras = {},
        monitors = {},
        alarms = {},
        keypads = {},
        other = {}
    }
    
    -- Escanear todos os periféricos conectados
    for _, name in ipairs(peripheral.getNames()) do
        local pType = peripheral.getType(name)
        local wrapped = peripheral.wrap(name)
        
        -- Detectar tipos SecurityCraft
        if string.find(name, "security") or string.find(name, "camera") then
            table.insert(devices.cameras, {name = name, type = pType, peripheral = wrapped})
        elseif string.find(name, "monitor") then
            table.insert(devices.monitors, {name = name, type = pType, peripheral = wrapped})
        elseif string.find(name, "alarm") then
            table.insert(devices.alarms, {name = name, type = pType, peripheral = wrapped})
        elseif string.find(name, "keypad") then
            table.insert(devices.keypads, {name = name, type = pType, peripheral = wrapped})
        else
            -- Tentar verificar métodos disponíveis
            if wrapped and type(wrapped) == "table" then
                local methods = {}
                for k, v in pairs(wrapped) do
                    if type(v) == "function" then
                        table.insert(methods, k)
                    end
                end
                
                if #methods > 0 then
                    table.insert(devices.other, {
                        name = name, 
                        type = pType, 
                        peripheral = wrapped,
                        methods = methods
                    })
                end
            end
        end
    end
    
    return devices
end

-- Interface de detecção
local function drawDetectionScreen(devices)
    monitor.clear()
    
    -- Título
    monitor.setBackgroundColor(colors.blue)
    monitor.setTextColor(colors.white)
    for x = 1, width do
        monitor.setCursorPos(x, 1)
        monitor.write(" ")
    end
    monitor.setCursorPos(2, 1)
    monitor.write("INTEGRACAO SecurityCraft + CC:Tweaked")
    
    monitor.setBackgroundColor(colors.black)
    local y = 3
    
    -- Câmeras
    monitor.setTextColor(colors.yellow)
    monitor.setCursorPos(2, y)
    monitor.write("CAMERAS DETECTADAS: " .. #devices.cameras)
    y = y + 1
    
    if #devices.cameras > 0 then
        for i, cam in ipairs(devices.cameras) do
            monitor.setTextColor(colors.lime)
            monitor.setCursorPos(4, y)
            monitor.write("+ " .. cam.name .. " (" .. cam.type .. ")")
            y = y + 1
        end
    else
        monitor.setTextColor(colors.red)
        monitor.setCursorPos(4, y)
        monitor.write("Nenhuma camera SecurityCraft conectada")
        y = y + 1
    end
    
    y = y + 1
    
    -- Alarmes
    monitor.setTextColor(colors.yellow)
    monitor.setCursorPos(2, y)
    monitor.write("ALARMES: " .. #devices.alarms)
    y = y + 1
    
    if #devices.alarms > 0 then
        for i, alarm in ipairs(devices.alarms) do
            monitor.setTextColor(colors.lime)
            monitor.setCursorPos(4, y)
            monitor.write("+ " .. alarm.name)
            y = y + 1
        end
    end
    
    y = y + 1
    
    -- Outros dispositivos
    monitor.setTextColor(colors.yellow)
    monitor.setCursorPos(2, y)
    monitor.write("OUTROS PERIFERICOS: " .. #devices.other)
    y = y + 1
    
    if #devices.other > 0 then
        for i, dev in ipairs(devices.other) do
            monitor.setTextColor(colors.cyan)
            monitor.setCursorPos(4, y)
            monitor.write("+ " .. dev.name .. " (" .. dev.type .. ")")
            y = y + 1
            
            -- Mostrar métodos disponíveis
            if dev.methods and #dev.methods > 0 then
                monitor.setTextColor(colors.lightGray)
                monitor.setCursorPos(6, y)
                monitor.write("Metodos: " .. table.concat(dev.methods, ", "))
                y = y + 1
            end
        end
    end
    
    y = y + 1
    
    -- Instruções
    monitor.setTextColor(colors.orange)
    monitor.setCursorPos(2, y)
    monitor.write("NOTA: SecurityCraft cameras NAO sao perifericos CC!")
    y = y + 1
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(2, y)
    monitor.write("Use Security Monitor (SecurityCraft) + controle CC")
    
    -- Rodapé
    monitor.setTextColor(colors.lightGray)
    monitor.setCursorPos(2, height - 1)
    monitor.write("[R] Rescanear  [Q] Sair")
end

-- Main
local function main()
    print("=== Teste de Integracao SecurityCraft + CC:Tweaked ===")
    print("")
    print("Escaneando perifericos...")
    
    local running = true
    
    while running do
        local devices = scanSecurityCraftDevices()
        
        -- Mostrar no terminal
        print("\n--- RESULTADOS DO SCAN ---")
        print("Cameras: " .. #devices.cameras)
        print("Alarmes: " .. #devices.alarms)
        print("Keypads: " .. #devices.keypads)
        print("Outros: " .. #devices.other)
        
        if #devices.other > 0 then
            print("\nDispositivos detectados:")
            for _, dev in ipairs(devices.other) do
                print("  - " .. dev.name .. " (" .. dev.type .. ")")
                if dev.methods then
                    print("    Metodos: " .. table.concat(dev.methods, ", "))
                end
            end
        end
        
        drawDetectionScreen(devices)
        
        print("\nPressione R para rescanear ou Q para sair")
        
        local event, key = os.pullEvent("key")
        
        if key == keys.q then
            running = false
        elseif key == keys.r then
            print("\nRescaneando...")
        end
    end
    
    monitor.clear()
    monitor.setCursorPos(1, 1)
    print("\nSistema encerrado.")
end

-- Executar
print("Iniciando detector de integracao...")
print("")
print("IMPORTANTE:")
print("- Conecte dispositivos SecurityCraft via cabo de rede")
print("- Alguns blocos SecurityCraft NAO sao perifericos")
print("- Este programa detecta o que e possivel conectar")
print("")

local success, err = pcall(main)
if not success then
    print("\nERRO: " .. tostring(err))
    monitor.clear()
    monitor.setTextColor(colors.red)
    monitor.setCursorPos(2, 2)
    monitor.write("ERRO: " .. tostring(err))
end
