-- SISTEMA HÍBRIDO: Controle CC + Visualização SecurityCraft
-- O que REALMENTE funciona entre os dois mods

local monitor = peripheral.find("monitor")
local modem = peripheral.find("modem")

if not monitor then
    error("Monitor CC:Tweaked não encontrado!")
end

-- CONFIGURAÇÃO: Suas câmeras SecurityCraft
-- (Adicione as coordenadas e nomes das suas câmeras)
local cameraDatabase = {
    {
        id = 1,
        name = "Entrada Principal",
        location = "x=100, y=64, z=200",
        securityMonitorSide = "left",  -- Lado onde conecta ao Security Monitor
        active = false
    },
    {
        id = 2,
        name = "Cofre VIP",
        location = "x=95, y=64, z=195",
        securityMonitorSide = "right",
        active = false
    },
    {
        id = 3,
        name = "Corredor Oeste",
        location = "x=105, y=64, z=205",
        securityMonitorSide = "back",
        active = false
    }
}

local selectedCamera = 1
local systemMode = "manual" -- "manual" ou "auto"
local autoSwitchInterval = 5

-- Inicializar
monitor.setTextScale(0.5)
local width, height = monitor.getSize()

-- Função: Alternar câmera via Redstone
local function switchCamera(cameraId)
    -- Desativar todas
    for _, cam in ipairs(cameraDatabase) do
        cam.active = false
        if cam.securityMonitorSide then
            redstone.setOutput(cam.securityMonitorSide, false)
        end
    end
    
    -- Ativar selecionada
    local cam = cameraDatabase[cameraId]
    if cam and cam.securityMonitorSide then
        redstone.setOutput(cam.securityMonitorSide, true)
        cam.active = true
        
        -- Enviar sinal wireless se tiver modem
        if modem then
            modem.transmit(100, 0, {
                action = "switch_camera",
                camera_id = cameraId,
                name = cam.name,
                timestamp = os.epoch("utc")
            })
        end
        
        return true
    end
    
    return false
end

-- Interface principal
local function drawInterface()
    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    
    -- Header
    monitor.setBackgroundColor(colors.gray)
    monitor.setTextColor(colors.white)
    for x = 1, width do
        monitor.setCursorPos(x, 1)
        monitor.write(" ")
        monitor.setCursorPos(x, 2)
        monitor.write(" ")
    end
    
    monitor.setCursorPos(2, 1)
    monitor.write("SISTEMA HIBRIDO: SecurityCraft + CC:Tweaked")
    monitor.setCursorPos(2, 2)
    monitor.write("Modo: " .. string.upper(systemMode) .. " | Hora: " .. textutils.formatTime(os.time()))
    
    -- Área de câmeras
    local y = 4
    monitor.setBackgroundColor(colors.black)
    
    for i, cam in ipairs(cameraDatabase) do
        if i == selectedCamera then
            monitor.setBackgroundColor(colors.blue)
            monitor.setTextColor(colors.white)
        else
            monitor.setBackgroundColor(colors.black)
            monitor.setTextColor(colors.gray)
        end
        
        -- Linha da câmera
        for x = 1, width do
            monitor.setCursorPos(x, y)
            monitor.write(" ")
        end
        
        monitor.setCursorPos(2, y)
        local status = cam.active and "[ON]" or "[--]"
        local indicator = cam.active and ">>>" or "   "
        
        monitor.write(indicator .. " CAM " .. cam.id .. " " .. status .. " " .. cam.name)
        
        y = y + 1
        
        -- Info adicional para câmera selecionada
        if i == selectedCamera then
            monitor.setBackgroundColor(colors.black)
            monitor.setTextColor(colors.lightGray)
            monitor.setCursorPos(8, y)
            monitor.write("Local: " .. cam.location)
            y = y + 1
            monitor.setCursorPos(8, y)
            monitor.write("Redstone: " .. (cam.securityMonitorSide or "N/A"))
            y = y + 1
        end
        
        y = y + 1
    end
    
    -- Instruções
    y = height - 6
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.yellow)
    monitor.setCursorPos(2, y)
    monitor.write("IMPORTANTE: Use Security Monitor (SecurityCraft) para ver o feed real!")
    
    y = y + 2
    monitor.setTextColor(colors.lime)
    monitor.setCursorPos(2, y)
    monitor.write("CONTROLES:")
    y = y + 1
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(2, y)
    monitor.write("[Seta Cima/Baixo] Selecionar | [Enter] Ativar Camera")
    y = y + 1
    monitor.setCursorPos(2, y)
    monitor.write("[M] Modo Auto/Manual | [Q] Sair")
end

-- Modo automático
local function autoMode()
    local currentCam = 1
    
    while systemMode == "auto" do
        switchCamera(currentCam)
        selectedCamera = currentCam
        drawInterface()
        
        -- Timer cancelável
        local timer = os.startTimer(autoSwitchInterval)
        
        while true do
            local event, param = os.pullEvent()
            
            if event == "timer" and param == timer then
                break
            elseif event == "key" then
                if param == keys.m then
                    systemMode = "manual"
                    return
                elseif param == keys.q then
                    return
                end
            end
        end
        
        currentCam = currentCam + 1
        if currentCam > #cameraDatabase then
            currentCam = 1
        end
    end
end

-- Input handler
local function handleInput()
    local event, key = os.pullEvent("key")
    
    if key == keys.up then
        selectedCamera = selectedCamera - 1
        if selectedCamera < 1 then
            selectedCamera = #cameraDatabase
        end
    elseif key == keys.down then
        selectedCamera = selectedCamera + 1
        if selectedCamera > #cameraDatabase then
            selectedCamera = 1
        end
    elseif key == keys.enter then
        switchCamera(selectedCamera)
    elseif key == keys.m then
        if systemMode == "manual" then
            systemMode = "auto"
            return "auto"
        else
            systemMode = "manual"
        end
    elseif key == keys.q then
        return "quit"
    end
    
    return "continue"
end

-- Main loop
local function main()
    print("=== Sistema Híbrido SecurityCraft + CC:Tweaked ===")
    print("")
    print("COMO FUNCIONA:")
    print("1. CC:Tweaked controla QUAL camera visualizar")
    print("2. SecurityCraft mostra o FEED REAL da camera")
    print("3. Redstone conecta os dois sistemas")
    print("")
    print("SETUP NECESSARIO:")
    print("- Security Cameras (SecurityCraft) instaladas")
    print("- Security Monitor (SecurityCraft) para visualizar")
    print("- Computer + Monitor (CC:Tweaked) para controlar")
    print("- Redstone conectando CC aos Security Monitors")
    print("")
    
    -- Ativar primeira câmera
    switchCamera(selectedCamera)
    
    local running = true
    
    while running do
        drawInterface()
        
        if systemMode == "auto" then
            autoMode()
        else
            local result = handleInput()
            if result == "quit" then
                running = false
            elseif result == "auto" then
                autoMode()
            end
        end
    end
    
    -- Cleanup: desativar tudo
    for i = 1, #cameraDatabase do
        switchCamera(i)
        redstone.setOutput(cameraDatabase[i].securityMonitorSide or "left", false)
    end
    
    monitor.clear()
    monitor.setCursorPos(1, 1)
    print("\nSistema encerrado.")
end

-- Executar
local success, err = pcall(main)
if not success then
    print("ERRO: " .. tostring(err))
    monitor.clear()
    monitor.setTextColor(colors.red)
    monitor.setCursorPos(2, 2)
    monitor.write("ERRO: " .. tostring(err))
end
