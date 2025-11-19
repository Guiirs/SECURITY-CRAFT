-- Sistema de Monitoramento de Câmeras SecurityCraft
-- Conecta câmeras do SecurityCraft com monitores do CC:Tweaked

local monitor = peripheral.find("monitor")
local camera = peripheral.find("camera") -- Peripheral do SecurityCraft

if not monitor then
    error("Nenhum monitor encontrado! Conecte um monitor ao computador.")
end

if not camera then
    error("Nenhuma câmera encontrada! Conecte uma Security Camera ao computador via cabo de rede (Networking Cable).")
end

-- Configuração do monitor
monitor.clear()
monitor.setTextScale(0.5)

-- Função para desenhar a interface
local function drawInterface()
    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    
    monitor.setTextColor(colors.yellow)
    monitor.setCursorPos(2, 2)
    monitor.write("=== SISTEMA DE SEGURANCA ===")
    
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(2, 4)
    monitor.write("Camera: Ativa")
    
    monitor.setCursorPos(2, 5)
    monitor.write("Status: Monitorando...")
end

-- Função para obter lista de câmeras conectadas
local function getCameras()
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

-- Função para capturar imagem da câmera
local function captureCamera(cam)
    if cam and cam.capture then
        return cam.capture()
    end
    return nil
end

-- Função principal de monitoramento
local function monitorCameras()
    local cameras = getCameras()
    
    if #cameras == 0 then
        monitor.setTextColor(colors.red)
        monitor.setCursorPos(2, 7)
        monitor.write("Nenhuma camera detectada!")
        return
    end
    
    local currentCamera = 1
    
    while true do
        drawInterface()
        
        -- Informações da câmera atual
        monitor.setTextColor(colors.lime)
        monitor.setCursorPos(2, 7)
        monitor.write("Camera " .. currentCamera .. "/" .. #cameras)
        monitor.setCursorPos(2, 8)
        monitor.write("ID: " .. cameras[currentCamera].name)
        
        -- Capturar visão da câmera
        local cam = cameras[currentCamera].peripheral
        
        -- Se a câmera tiver método de captura, usar
        if cam.capture then
            local image = cam.capture()
            if image then
                monitor.setCursorPos(2, 10)
                monitor.setTextColor(colors.white)
                monitor.write("Imagem capturada!")
            end
        end
        
        -- Mostrar controles
        monitor.setTextColor(colors.gray)
        monitor.setCursorPos(2, 12)
        monitor.write("Controles:")
        monitor.setCursorPos(2, 13)
        monitor.write("[Setas] Trocar camera")
        monitor.setCursorPos(2, 14)
        monitor.write("[Q] Sair")
        
        -- Aguardar entrada
        sleep(1)
        
        -- Verificar eventos de teclado
        local event, key = os.pullEvent("key")
        
        if key == keys.right then
            currentCamera = currentCamera + 1
            if currentCamera > #cameras then
                currentCamera = 1
            end
        elseif key == keys.left then
            currentCamera = currentCamera - 1
            if currentCamera < 1 then
                currentCamera = #cameras
            end
        elseif key == keys.q then
            break
        end
    end
end

-- Iniciar o sistema
print("Iniciando sistema de monitoramento...")
drawInterface()

local success, err = pcall(monitorCameras)
if not success then
    monitor.setTextColor(colors.red)
    monitor.setCursorPos(2, 10)
    monitor.write("Erro: " .. tostring(err))
    print("Erro: " .. tostring(err))
end

monitor.clear()
monitor.setCursorPos(1, 1)
print("Sistema encerrado.")
