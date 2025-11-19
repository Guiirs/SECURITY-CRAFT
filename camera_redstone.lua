-- Sistema Integrado: CC:Tweaked + SecurityCraft
-- Usa Redstone para controlar Security Monitors

local monitor = peripheral.find("monitor")
local modem = peripheral.find("modem")

if not monitor then
    error("Monitor nao encontrado!")
end

-- Configuração das câmeras e canais redstone
local cameras = {
    {
        id = 1,
        name = "Entrada",
        redstoneOutput = "left",  -- Lado onde está o redstone
        channel = 1                -- Canal do redstone integrator
    },
    {
        id = 2,
        name = "Cofre",
        redstoneOutput = "right",
        channel = 2
    },
    {
        id = 3,
        name = "Corredor",
        redstoneOutput = "back",
        channel = 3
    }
}

local currentCamera = 1

-- Inicializar
monitor.setTextScale(0.5)
monitor.setBackgroundColor(colors.black)
local width, height = monitor.getSize()

-- Função para ativar câmera via redstone
local function activateCamera(cameraId)
    local cam = cameras[cameraId]
    
    -- Desativar todas as câmeras
    for _, c in ipairs(cameras) do
        if c.redstoneOutput then
            redstone.setOutput(c.redstoneOutput, false)
        end
    end
    
    -- Ativar câmera selecionada
    if cam.redstoneOutput then
        redstone.setOutput(cam.redstoneOutput, true)
        print("Camera " .. cam.id .. " ativada via redstone")
    end
    
    -- Se tiver modem wireless, enviar sinal
    if modem then
        modem.transmit(cam.channel, 0, {
            action = "activate_camera",
            camera = cam.id,
            name = cam.name
        })
    end
end

-- Interface
local function drawInterface()
    monitor.clear()
    
    -- Título
    monitor.setBackgroundColor(colors.gray)
    monitor.setTextColor(colors.white)
    for x = 1, width do
        monitor.setCursorPos(x, 1)
        monitor.write(" ")
    end
    monitor.setCursorPos(math.floor(width/2 - 10), 1)
    monitor.write("CONTROLE DE CAMERAS")
    
    -- Lista de câmeras
    monitor.setBackgroundColor(colors.black)
    local y = 3
    
    for i, cam in ipairs(cameras) do
        if i == currentCamera then
            monitor.setBackgroundColor(colors.blue)
            monitor.setTextColor(colors.white)
        else
            monitor.setBackgroundColor(colors.black)
            monitor.setTextColor(colors.lightGray)
        end
        
        monitor.setCursorPos(2, y)
        monitor.write(string.rep(" ", width - 2))
        monitor.setCursorPos(3, y)
        monitor.write("[" .. cam.id .. "] " .. cam.name)
        
        if i == currentCamera then
            monitor.setCursorPos(width - 10, y)
            monitor.write("< ATIVA >")
        end
        
        y = y + 2
    end
    
    -- Instruções
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.yellow)
    monitor.setCursorPos(2, height - 3)
    monitor.write("Redstone Output: " .. cameras[currentCamera].redstoneOutput)
    
    monitor.setTextColor(colors.lightGray)
    monitor.setCursorPos(2, height - 1)
    monitor.write("[Setas] Mudar | [Enter] Ativar | [Q] Sair")
end

-- Processar input
local function handleInput()
    local event, key = os.pullEvent("key")
    
    if key == keys.up then
        currentCamera = currentCamera - 1
        if currentCamera < 1 then
            currentCamera = #cameras
        end
    elseif key == keys.down then
        currentCamera = currentCamera + 1
        if currentCamera > #cameras then
            currentCamera = 1
        end
    elseif key == keys.enter then
        activateCamera(currentCamera)
    elseif key == keys.q then
        return false
    end
    
    return true
end

-- Main loop
local function main()
    print("Sistema de controle iniciado")
    print("Total de cameras: " .. #cameras)
    
    -- Ativar primeira câmera
    activateCamera(currentCamera)
    
    local running = true
    
    while running do
        drawInterface()
        running = handleInput()
    end
    
    -- Desativar todas ao sair
    for _, cam in ipairs(cameras) do
        if cam.redstoneOutput then
            redstone.setOutput(cam.redstoneOutput, false)
        end
    end
    
    monitor.clear()
    monitor.setCursorPos(1, 1)
    print("Sistema encerrado")
end

-- Executar
local success, err = pcall(main)
if not success then
    print("ERRO: " .. tostring(err))
end
