-- Sistema de Grade de Câmeras (múltiplas câmeras em um monitor)
-- Exibe várias câmeras simultaneamente

local monitor = peripheral.find("monitor")

if not monitor then
    error("Monitor não encontrado!")
end

-- Função para obter todas as câmeras
local function getAllCameras()
    local cameras = {}
    for _, name in ipairs(peripheral.getNames()) do
        if peripheral.getType(name) == "camera" then
            table.insert(cameras, {
                name = name,
                peripheral = peripheral.wrap(name)
            })
        end
    end
    return cameras
end

-- Configurar monitor
monitor.setTextScale(0.5)
local width, height = monitor.getSize()

-- Função para desenhar grade de câmeras
local function drawCameraGrid(cameras)
    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    
    -- Cabeçalho
    monitor.setTextColor(colors.yellow)
    monitor.setCursorPos(math.floor(width/2 - 8), 1)
    monitor.write("CENTRAL DE SEGURANCA")
    
    -- Calcular layout da grade
    local numCameras = #cameras
    local cols = math.ceil(math.sqrt(numCameras))
    local rows = math.ceil(numCameras / cols)
    
    local cellWidth = math.floor(width / cols)
    local cellHeight = math.floor((height - 2) / rows)
    
    -- Desenhar cada câmera
    for i, cam in ipairs(cameras) do
        local col = (i - 1) % cols
        local row = math.floor((i - 1) / cols)
        
        local x = col * cellWidth + 1
        local y = row * cellHeight + 3
        
        -- Desenhar borda da célula
        monitor.setTextColor(colors.blue)
        monitor.setCursorPos(x, y)
        monitor.write(string.rep("-", cellWidth - 1))
        
        -- Nome da câmera
        monitor.setTextColor(colors.white)
        monitor.setCursorPos(x + 1, y + 1)
        monitor.write("CAM " .. i)
        
        -- Status
        monitor.setTextColor(colors.lime)
        monitor.setCursorPos(x + 1, y + 2)
        monitor.write("[ATIVA]")
        
        -- Simular visualização
        monitor.setTextColor(colors.gray)
        for line = 3, cellHeight - 2 do
            monitor.setCursorPos(x + 1, y + line)
            monitor.write(string.rep(".", cellWidth - 2))
        end
    end
    
    -- Rodapé
    monitor.setTextColor(colors.lightGray)
    monitor.setCursorPos(2, height)
    monitor.write("Total: " .. numCameras .. " cameras | [Q] Sair")
end

-- Loop principal
local function main()
    while true do
        local cameras = getAllCameras()
        
        if #cameras == 0 then
            monitor.clear()
            monitor.setTextColor(colors.red)
            monitor.setCursorPos(2, 2)
            monitor.write("NENHUMA CAMERA CONECTADA")
            monitor.setTextColor(colors.white)
            monitor.setCursorPos(2, 4)
            monitor.write("Conecte cameras via cabo de rede")
        else
            drawCameraGrid(cameras)
        end
        
        -- Atualizar a cada 2 segundos
        local timer = os.startTimer(2)
        
        while true do
            local event, param = os.pullEvent()
            
            if event == "timer" and param == timer then
                break
            elseif event == "key" and param == keys.q then
                monitor.clear()
                monitor.setCursorPos(1, 1)
                return
            end
        end
    end
end

-- Iniciar
print("Sistema de grade de cameras iniciado!")
print("Pressione Q no computador para sair.")

local success, err = pcall(main)
if not success then
    print("Erro: " .. tostring(err))
    monitor.clear()
    monitor.setTextColor(colors.red)
    monitor.setCursorPos(2, 2)
    monitor.write("ERRO: " .. tostring(err))
end
