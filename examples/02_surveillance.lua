-- Exemplo 2: Sistema de Vigilância com Monitor
-- Mostra feed da câmera em tempo real

local camera = peripheral.find("security_camera")
local monitor = peripheral.find("monitor")

if not camera then
    error("Camera nao encontrada!")
end

if not monitor then
    error("Monitor nao encontrado!")
end

-- Configurar monitor
monitor.setTextScale(0.5)
monitor.clear()
local width, height = monitor.getSize()

-- Função para desenhar interface
local function drawInterface(capture)
    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    
    -- Cabeçalho
    monitor.setBackgroundColor(colors.blue)
    monitor.setTextColor(colors.white)
    for x = 1, width do
        monitor.setCursorPos(x, 1)
        monitor.write(" ")
    end
    monitor.setCursorPos(2, 1)
    monitor.write("CAMERA DE SEGURANCA - FEED AO VIVO")
    
    -- Informações
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.yellow)
    monitor.setCursorPos(2, 3)
    monitor.write("Camera ID: " .. capture.position.x .. "," .. capture.position.y .. "," .. capture.position.z)
    
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(2, 5)
    monitor.write("Rotacao:")
    monitor.setCursorPos(4, 6)
    monitor.write("Yaw: " .. string.format("%.1f", capture.rotation.yaw))
    monitor.setCursorPos(4, 7)
    monitor.write("Pitch: " .. string.format("%.1f", capture.rotation.pitch))
    
    -- Entidades detectadas
    monitor.setCursorPos(2, 9)
    monitor.write("Entidades Detectadas: " .. capture.entityCount)
    
    local y = 11
    if capture.entityCount > 0 then
        for i, entity in ipairs(capture.entities) do
            if y <= height - 2 then
                monitor.setTextColor(entity.isPlayer and colors.red or colors.lime)
                monitor.setCursorPos(4, y)
                local name = entity.name:sub(1, 20)  -- Truncar nome
                local dist = string.format("%.1f", entity.distance)
                monitor.write("- " .. name .. " (" .. dist .. "m)")
                y = y + 1
            end
        end
    else
        monitor.setTextColor(colors.gray)
        monitor.setCursorPos(4, y)
        monitor.write("Nenhuma entidade detectada")
    end
    
    -- Status de movimento
    if capture.motionDetected then
        monitor.setBackgroundColor(colors.red)
        monitor.setTextColor(colors.white)
    else
        monitor.setBackgroundColor(colors.green)
        monitor.setTextColor(colors.black)
    end
    
    for x = 1, width do
        monitor.setCursorPos(x, height)
        monitor.write(" ")
    end
    monitor.setCursorPos(2, height)
    monitor.write(capture.motionDetected and "[MOVIMENTO DETECTADO]" or "[SEM MOVIMENTO]")
end

-- Loop principal
print("Sistema de vigilancia iniciado!")
print("Pressione Ctrl+T para parar")

while true do
    -- Capturar dados da câmera
    local capture = camera.capture()
    
    if capture.error then
        print("Erro: " .. capture.error)
        sleep(1)
    else
        -- Atualizar display
        drawInterface(capture)
        
        -- Alerta se detectar jogador
        for _, entity in ipairs(capture.entities) do
            if entity.isPlayer then
                print("ALERTA: Jogador detectado - " .. entity.name)
            end
        end
    end
    
    sleep(1)  -- Atualizar a cada 1 segundo
end
