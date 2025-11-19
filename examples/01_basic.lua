-- Exemplo 1: Básico - Conectar e obter informações da câmera
-- Conecte uma Security Camera ao computador via cabo de rede

local camera = peripheral.find("security_camera")

if not camera then
    print("Nenhuma camera encontrada!")
    print("Conecte uma Security Camera via Networking Cable")
    return
end

print("=== CAMERA ENCONTRADA ===")
print("")

-- Obter informações básicas
local info = camera.getInfo()
print("ID: " .. info.id)
print("Posicao: " .. info.x .. ", " .. info.y .. ", " .. info.z)
print("Ativa: " .. tostring(info.active))
print("Rotacao: Yaw=" .. info.yaw .. ", Pitch=" .. info.pitch)
print("Distancia de visao: " .. info.viewDistance .. " blocos")

print("")
print("=== STATUS ATUAL ===")
local status = camera.getStatus()
print("Online: " .. tostring(status.online))
print("Nivel de luz: " .. status.lightLevel)
print("Periodo: " .. status.timeOfDay)
print("Entidades visiveis: " .. status.entitiesInView)
print("Movimento detectado: " .. tostring(status.motionDetected))
