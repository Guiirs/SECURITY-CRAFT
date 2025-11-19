-- Exemplo 3: Sistema de Múltiplas Câmeras
-- Gerencia e alterna entre várias câmeras

local monitor = peripheral.find("monitor")

if not monitor then
    error("Monitor nao encontrado!")
end

-- Encontrar todas as câmeras
local cameras = {peripheral.find("security_camera")}

if #cameras == 0 then
    error("Nenhuma camera encontrada!")
end

print("Encontradas " .. #cameras .. " cameras")

-- Configurar
monitor.setTextScale(0.5)
local width, height = monitor.getSize()
local currentCamera = 1
local autoSwitch = true
local switchInterval = 5

-- Interface
local function drawCameraList()
    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    
    -- Título
    monitor.setBackgroundColor(colors.gray)
    monitor.setTextColor(colors.white)
    for x = 1, width do
        monitor.setCursorPos(x, 1)
        monitor.write(" ")
    end
    monitor.setCursorPos(2, 1)
    monitor.write("CENTRAL DE SEGURANCA - " .. #cameras .. " CAMERAS")
    
    -- Lista de câmeras
    local y = 3
    for i, cam in ipairs(cameras) do
        local info = cam.getInfo()
        local status = cam.getStatus()
        
        if i == currentCamera then
            monitor.setBackgroundColor(colors.blue)
            monitor.setTextColor(colors.white)
        else
            monitor.setBackgroundColor(colors.black)
            monitor.setTextColor(colors.gray)
        end
        
        for x = 1, width do
            monitor.setCursorPos(x, y)
            monitor.write(" ")
        end
        
        monitor.setCursorPos(2, y)
        local indicator = i == currentCamera and ">>>" or "   "
        monitor.write(indicator .. " CAM " .. i .. " - " .. info.id)
        
        monitor.setCursorPos(width - 15, y)
        monitor.write("Entidades: " .. status.entitiesInView)
        
        y = y + 1
        
        -- Detalhes da câmera ativa
        if i == currentCamera then
            monitor.setBackgroundColor(colors.black)
            monitor.setTextColor(colors.yellow)
            monitor.setCursorPos(6, y)
            monitor.write("Pos: " .. info.x .. "," .. info.y .. "," .. info.z)
            y = y + 1
            
            monitor.setTextColor(colors.white)
            monitor.setCursorPos(6, y)
            monitor.write("Luz: " .. status.lightLevel .. " | " .. status.timeOfDay)
            y = y + 1
            
            if status.motionDetected then
                monitor.setTextColor(colors.red)
                monitor.setCursorPos(6, y)
                monitor.write("[MOVIMENTO DETECTADO]")
                y = y + 1
            end
        end
        
        y = y + 1
    end
    
    -- Controles
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.lightGray)
    monitor.setCursorPos(2, height - 2)
    monitor.write("Modo: " .. (autoSwitch and "AUTOMATICO" or "MANUAL"))
    monitor.setCursorPos(2, height - 1)
    monitor.write("[<][>] Trocar | [M] Modo | [Q] Sair")
end

-- Função para alternar câmera
local function switchCamera(direction)
    currentCamera = currentCamera + direction
    if currentCamera > #cameras then
        currentCamera = 1
    elseif currentCamera < 1 then
        currentCamera = #cameras
    end
    print("Alternando para camera " .. currentCamera)
end

-- Input handler
local function handleInput()
    local event, key = os.pullEvent("key")
    
    if key == keys.right then
        switchCamera(1)
        autoSwitch = false
    elseif key == keys.left then
        switchCamera(-1)
        autoSwitch = false
    elseif key == keys.m then
        autoSwitch = not autoSwitch
        print("Modo " .. (autoSwitch and "automatico" or "manual"))
    elseif key == keys.q then
        return false
    end
    
    return true
end

-- Loop principal
print("Sistema de multiplas cameras iniciado!")

local lastSwitch = os.epoch("utc")
local running = true

while running do
    drawCameraList()
    
    -- Auto-switch
    if autoSwitch then
        local now = os.epoch("utc")
        if now - lastSwitch > (switchInterval * 1000) then
            switchCamera(1)
            lastSwitch = now
        end
    end
    
    -- Check input (non-blocking)
    local timer = os.startTimer(0.5)
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
print("Sistema encerrado")
