-- Exemplo 4: Sistema de Alarme com Detecção de Movimento
-- Detecta movimento e dispara alarme

local camera = peripheral.find("security_camera")
local monitor = peripheral.find("monitor")
local speaker = peripheral.find("speaker")  -- Opcional

if not camera then
    error("Camera nao encontrada!")
end

if not monitor then
    error("Monitor nao encontrado!")
end

-- Configurações
local SENSITIVITY = 3  -- Número mínimo de entidades para alarme
local CHECK_INTERVAL = 0.5  -- Segundos entre checks
local ALARM_DURATION = 5  -- Segundos de alarme ativo

-- Estado
local alarmActive = false
local lastAlarmTime = 0
local detectionHistory = {}

-- Setup monitor
monitor.setTextScale(0.7)
local width, height = monitor.getSize()

-- Função de alarme
local function triggerAlarm(entities)
    alarmActive = true
    lastAlarmTime = os.epoch("utc")
    
    print("!!! ALARME !!!")
    print("Entidades detectadas: " .. #entities)
    
    for _, entity in ipairs(entities) do
        print("- " .. entity.name .. " (" .. entity.type .. ")")
        
        if entity.isPlayer then
            print("  [JOGADOR DETECTADO!]")
        end
    end
    
    -- Tocar som se tiver speaker
    if speaker then
        speaker.playSound("minecraft:block.note_block.bass", 3, 0.5)
    end
end

-- Interface
local function drawAlarmStatus()
    monitor.clear()
    
    -- Cabeçalho
    if alarmActive then
        monitor.setBackgroundColor(colors.red)
    else
        monitor.setBackgroundColor(colors.green)
    end
    
    monitor.setTextColor(colors.white)
    for x = 1, width do
        for y = 1, 3 do
            monitor.setCursorPos(x, y)
            monitor.write(" ")
        end
    end
    
    monitor.setCursorPos(math.floor(width/2 - 6), 2)
    if alarmActive then
        monitor.write("!!! ALARME !!!")
    else
        monitor.write("SISTEMA ATIVO")
    end
    
    -- Status da câmera
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.yellow)
    monitor.setCursorPos(2, 5)
    monitor.write("CAMERA DE SEGURANCA")
    
    local info = camera.getInfo()
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(2, 6)
    monitor.write("Posicao: " .. info.x .. ", " .. info.y .. ", " .. info.z)
    
    local status = camera.getStatus()
    monitor.setCursorPos(2, 7)
    monitor.write("Luz: " .. status.lightLevel .. " | " .. status.timeOfDay)
    
    -- Histórico de detecções
    monitor.setTextColor(colors.cyan)
    monitor.setCursorPos(2, 9)
    monitor.write("ULTIMAS DETECCOES:")
    
    local y = 10
    for i = #detectionHistory, math.max(1, #detectionHistory - 5), -1 do
        local detection = detectionHistory[i]
        monitor.setTextColor(colors.lightGray)
        monitor.setCursorPos(2, y)
        monitor.write(detection.time .. " - " .. detection.count .. " entidades")
        y = y + 1
    end
    
    -- Instruções
    monitor.setTextColor(colors.gray)
    monitor.setCursorPos(2, height - 1)
    monitor.write("Sensibilidade: " .. SENSITIVITY .. " | [Q] Sair")
end

-- Loop principal
print("=== Sistema de Alarme Iniciado ===")
print("Sensibilidade: " .. SENSITIVITY .. " entidades")
print("Intervalo de check: " .. CHECK_INTERVAL .. "s")
print("")

local running = true

while running do
    -- Capturar dados
    local capture = camera.capture()
    
    if not capture.error then
        local entityCount = #capture.entities
        
        -- Registrar detecção
        if entityCount > 0 then
            table.insert(detectionHistory, {
                time = os.date("%H:%M:%S"),
                count = entityCount
            })
            
            -- Limitar histórico
            if #detectionHistory > 20 then
                table.remove(detectionHistory, 1)
            end
        end
        
        -- Check alarme
        if entityCount >= SENSITIVITY then
            if not alarmActive then
                triggerAlarm(capture.entities)
            end
        else
            -- Desativar alarme após duração
            if alarmActive then
                local elapsed = (os.epoch("utc") - lastAlarmTime) / 1000
                if elapsed > ALARM_DURATION then
                    alarmActive = false
                    print("Alarme desativado")
                end
            end
        end
    end
    
    -- Atualizar display
    drawAlarmStatus()
    
    -- Check for quit
    local timer = os.startTimer(CHECK_INTERVAL)
    while true do
        local event, param = os.pullEvent()
        
        if event == "timer" and param == timer then
            break
        elseif event == "key" and param == keys.q then
            running = false
            break
        end
    end
end

monitor.clear()
monitor.setCursorPos(1, 1)
print("Sistema de alarme encerrado")
