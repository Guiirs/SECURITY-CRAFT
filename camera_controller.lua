-- Sistema de Câmeras SecurityCraft v2.0
-- Usa Security Monitor como intermediário
-- Não requer conexão direta às câmeras

local monitor = peripheral.find("monitor")

if not monitor then
    error("Monitor nao encontrado! Conecte um monitor ao computador.")
end

-- Configuração
local config = {
    updateInterval = 2,
    monitorScale = 0.5
}

-- Inicializar monitor
monitor.setTextScale(config.monitorScale)
monitor.setBackgroundColor(colors.black)
local width, height = monitor.getSize()

-- Lista de câmeras (configurar manualmente)
local cameras = {
    {id = 1, name = "Entrada Principal", x = 100, y = 64, z = 200},
    {id = 2, name = "Cofre", x = 95, y = 64, z = 195},
    {id = 3, name = "Corredor", x = 105, y = 64, z = 205},
    -- Adicione mais câmeras aqui
}

local currentCamera = 1
local recording = false

-- Função para desenhar interface
local function drawInterface()
    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    
    -- Cabeçalho
    monitor.setBackgroundColor(colors.gray)
    monitor.setTextColor(colors.white)
    for x = 1, width do
        monitor.setCursorPos(x, 1)
        monitor.write(" ")
    end
    monitor.setCursorPos(math.floor(width/2 - 12), 1)
    monitor.write("SISTEMA DE SEGURANCA")
    
    -- Hora
    monitor.setCursorPos(width - 8, 1)
    monitor.write(textutils.formatTime(os.time(), false))
end

-- Função para desenhar visualização da câmera
local function drawCameraView()
    local cam = cameras[currentCamera]
    
    -- Área de visualização
    local viewY = 3
    local viewHeight = height - 7
    
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.blue)
    
    -- Borda
    monitor.setCursorPos(2, viewY)
    monitor.write("+" .. string.rep("-", width - 3) .. "+")
    
    for y = viewY + 1, viewY + viewHeight - 1 do
        monitor.setCursorPos(2, y)
        monitor.write("|")
        monitor.setCursorPos(width - 1, y)
        monitor.write("|")
    end
    
    monitor.setCursorPos(2, viewY + viewHeight)
    monitor.write("+" .. string.rep("-", width - 3) .. "+")
    
    -- Info da câmera
    monitor.setTextColor(colors.yellow)
    monitor.setCursorPos(4, viewY + 1)
    monitor.write("Camera " .. cam.id .. ": " .. cam.name)
    
    monitor.setTextColor(colors.lime)
    monitor.setCursorPos(4, viewY + 2)
    monitor.write("Status: ONLINE")
    
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(4, viewY + 3)
    monitor.write("Localizacao: " .. cam.x .. ", " .. cam.y .. ", " .. cam.z)
    
    -- Mensagem sobre Security Monitor
    monitor.setTextColor(colors.lightGray)
    local centerY = viewY + math.floor(viewHeight / 2)
    monitor.setCursorPos(4, centerY)
    monitor.write("Use o Security Monitor do SecurityCraft")
    monitor.setCursorPos(4, centerY + 1)
    monitor.write("para visualizar o feed desta camera")
    
    if recording then
        monitor.setTextColor(colors.red)
        monitor.setCursorPos(4, centerY + 3)
        monitor.write("[REC] GRAVANDO")
    end
end

-- Função para desenhar controles
local function drawControls()
    local controlY = height - 3
    
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.lightGray)
    
    monitor.setCursorPos(2, controlY)
    monitor.write("CONTROLES:")
    monitor.setCursorPos(2, controlY + 1)
    monitor.write("[<][>] Trocar  [R] Gravar  [Q] Sair")
end

-- Função para desenhar status
local function drawStatus()
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.yellow)
    monitor.setCursorPos(2, height)
    monitor.write("Cameras: " .. #cameras .. " | Camera Atual: " .. currentCamera)
end

-- Atualizar tela
local function updateDisplay()
    drawInterface()
    drawCameraView()
    drawControls()
    drawStatus()
end

-- Processar entrada
local function handleInput()
    local event, key = os.pullEvent("key")
    
    if key == keys.right then
        currentCamera = currentCamera + 1
        if currentCamera > #cameras then
            currentCamera = 1
        end
        return true
    elseif key == keys.left then
        currentCamera = currentCamera - 1
        if currentCamera < 1 then
            currentCamera = #cameras
        end
        return true
    elseif key == keys.r then
        recording = not recording
        return true
    elseif key == keys.q then
        return false
    end
    
    return true
end

-- Loop principal
local function main()
    print("=== Sistema de Cameras SecurityCraft ===")
    print("Total de cameras: " .. #cameras)
    print("")
    print("IMPORTANTE:")
    print("- Use Security Monitors para visualizar cameras")
    print("- Este sistema controla qual camera monitorar")
    print("")
    
    local running = true
    
    while running do
        updateDisplay()
        
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

-- Iniciar
local success, err = pcall(main)
if not success then
    print("ERRO: " .. tostring(err))
    monitor.clear()
    monitor.setBackgroundColor(colors.red)
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(2, 2)
    monitor.write("ERRO: " .. tostring(err))
end
