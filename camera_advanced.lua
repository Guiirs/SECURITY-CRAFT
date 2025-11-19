-- Sistema Avançado de Monitoramento com Detecção de Movimento
-- Integração completa SecurityCraft + CC:Tweaked

local monitor = peripheral.find("monitor")
local modem = peripheral.find("modem")

if not monitor then
    error("Monitor não encontrado!")
end

-- Configurações
local config = {
    updateInterval = 1, -- segundos
    motionSensitivity = 5,
    alertColor = colors.red,
    normalColor = colors.lime
}

-- Estado do sistema
local state = {
    cameras = {},
    selectedCamera = 1,
    alerts = {},
    recording = false
}

-- Inicializar monitor
monitor.setTextScale(0.5)
local monWidth, monHeight = monitor.getSize()

-- Funções de utilidade
local function scanCameras()
    local cameras = {}
    for _, name in ipairs(peripheral.getNames()) do
        local pType = peripheral.getType(name)
        if pType == "camera" or string.find(name, "security_camera") then
            table.insert(cameras, {
                id = #cameras + 1,
                name = name,
                peripheral = peripheral.wrap(name),
                status = "online",
                lastActivity = os.epoch("local")
            })
        end
    end
    return cameras
end

local function drawHeader()
    monitor.setBackgroundColor(colors.gray)
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(1, 1)
    monitor.clearLine()
    
    local title = " SISTEMA DE SEGURANCA - SecurityCraft "
    local padding = math.floor((monWidth - #title) / 2)
    monitor.setCursorPos(padding, 1)
    monitor.write(title)
    
    -- Hora atual
    monitor.setCursorPos(monWidth - 8, 1)
    monitor.write(textutils.formatTime(os.time(), false))
end

local function drawCameraView()
    monitor.setBackgroundColor(colors.black)
    
    -- Área de visualização
    local viewX, viewY = 2, 3
    local viewWidth, viewHeight = monWidth - 2, monHeight - 8
    
    for y = viewY, viewY + viewHeight do
        monitor.setCursorPos(viewX, y)
        monitor.write(string.rep(" ", viewWidth))
    end
    
    -- Borda da visualização
    monitor.setTextColor(colors.blue)
    monitor.setCursorPos(viewX, viewY)
    monitor.write("+" .. string.rep("-", viewWidth - 2) .. "+")
    monitor.setCursorPos(viewX, viewY + viewHeight)
    monitor.write("+" .. string.rep("-", viewWidth - 2) .. "+")
    
    for y = viewY + 1, viewY + viewHeight - 1 do
        monitor.setCursorPos(viewX, y)
        monitor.write("|")
        monitor.setCursorPos(viewX + viewWidth - 1, y)
        monitor.write("|")
    end
    
    -- Informações da câmera
    if #state.cameras > 0 then
        local cam = state.cameras[state.selectedCamera]
        monitor.setTextColor(colors.white)
        monitor.setCursorPos(viewX + 2, viewY + 1)
        monitor.write("Camera " .. cam.id .. ": " .. cam.name)
        
        monitor.setTextColor(config.normalColor)
        monitor.setCursorPos(viewX + 2, viewY + 2)
        monitor.write("Status: " .. string.upper(cam.status))
        
        -- Simular feed de vídeo
        monitor.setTextColor(colors.gray)
        local centerY = viewY + math.floor(viewHeight / 2)
        local centerX = viewX + math.floor(viewWidth / 2)
        monitor.setCursorPos(centerX - 7, centerY)
        monitor.write("[FEED DE VIDEO]")
    else
        monitor.setTextColor(colors.red)
        local centerY = viewY + math.floor(viewHeight / 2)
        monitor.setCursorPos(viewX + math.floor(viewWidth / 2) - 10, centerY)
        monitor.write("SEM CAMERAS CONECTADAS")
    end
end

local function drawControls()
    local controlY = monHeight - 4
    
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.lightGray)
    
    monitor.setCursorPos(2, controlY)
    monitor.write("CONTROLES:")
    
    monitor.setCursorPos(2, controlY + 1)
    monitor.write("[<] [>] Trocar Camera  [R] Gravar  [A] Alertas")
    
    monitor.setCursorPos(2, controlY + 2)
    monitor.write("[S] Escanear  [Q] Sair")
    
    -- Status de gravação
    if state.recording then
        monitor.setTextColor(colors.red)
        monitor.setCursorPos(monWidth - 15, controlY)
        monitor.write("[REC] GRAVANDO")
    end
end

local function drawStats()
    local statsY = monHeight - 1
    
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.yellow)
    
    monitor.setCursorPos(2, statsY)
    monitor.write("Cameras: " .. #state.cameras)
    
    monitor.setCursorPos(20, statsY)
    monitor.write("Alertas: " .. #state.alerts)
    
    if modem then
        monitor.setCursorPos(35, statsY)
        monitor.write("Rede: ATIVA")
    end
end

local function updateDisplay()
    drawHeader()
    drawCameraView()
    drawControls()
    drawStats()
end

local function handleInput()
    local event, key = os.pullEvent("key")
    
    if key == keys.right then
        state.selectedCamera = state.selectedCamera + 1
        if state.selectedCamera > #state.cameras then
            state.selectedCamera = 1
        end
    elseif key == keys.left then
        state.selectedCamera = state.selectedCamera - 1
        if state.selectedCamera < 1 then
            state.selectedCamera = #state.cameras
        end
    elseif key == keys.r then
        state.recording = not state.recording
        if state.recording then
            print("Gravação iniciada na camera " .. state.selectedCamera)
        else
            print("Gravação pausada")
        end
    elseif key == keys.s then
        state.cameras = scanCameras()
        print("Escaneamento completo. " .. #state.cameras .. " cameras encontradas.")
    elseif key == keys.a then
        print("Alertas: " .. #state.alerts)
    elseif key == keys.q then
        return false
    end
    
    return true
end

-- Loop principal
local function main()
    monitor.clear()
    print("=== Sistema de Monitoramento SecurityCraft ===")
    print("Escaneando cameras...")
    
    state.cameras = scanCameras()
    print("Encontradas " .. #state.cameras .. " cameras")
    
    if #state.cameras == 0 then
        print("AVISO: Nenhuma camera encontrada!")
        print("Conecte Security Cameras via Network Cable")
    end
    
    local running = true
    
    while running do
        updateDisplay()
        
        -- Timer de atualização
        local timer = os.startTimer(config.updateInterval)
        
        while true do
            local event, param = os.pullEvent()
            
            if event == "timer" and param == timer then
                break
            elseif event == "key" then
                running = handleInput()
                break
            end
        end
    end
    
    monitor.clear()
    monitor.setCursorPos(1, 1)
    print("Sistema encerrado.")
end

-- Iniciar sistema
local success, err = pcall(main)
if not success then
    print("ERRO: " .. tostring(err))
    monitor.clear()
    monitor.setBackgroundColor(colors.red)
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(2, 2)
    monitor.write("ERRO CRITICO: " .. tostring(err))
end
