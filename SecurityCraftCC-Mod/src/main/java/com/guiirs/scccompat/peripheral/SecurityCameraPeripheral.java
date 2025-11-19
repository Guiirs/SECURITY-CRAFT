package com.guiirs.scccompat.peripheral;

import dan200.computercraft.api.lua.LuaFunction;
import dan200.computercraft.api.peripheral.IPeripheral;
import net.minecraft.core.BlockPos;
import net.minecraft.core.Direction;
import net.minecraft.world.level.Level;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.annotation.Nonnull;
import java.util.*;

/**
 * Peripheral implementation for SecurityCraft Security Camera
 * Exposes camera functionality to CC:Tweaked computers
 */
public class SecurityCameraPeripheral implements IPeripheral {
    
    private final Level level;
    private final BlockPos cameraPos;
    private final String cameraId;
    private boolean isActive;
    private float yaw;
    private float pitch;
    private int viewDistance;
    
    public SecurityCameraPeripheral(Level level, BlockPos pos) {
        this.level = level;
        this.cameraPos = pos;
        this.cameraId = "camera_" + pos.toShortString();
        this.isActive = true;
        this.yaw = 0.0f;
        this.pitch = 0.0f;
        this.viewDistance = 32;
    }
    
    @NotNull
    @Override
    public String getType() {
        return "security_camera";
    }
    
    @Override
    public boolean equals(@Nullable IPeripheral other) {
        return this == other;
    }
    
    // ========== LUA API METHODS ==========
    
    /**
     * Get basic camera information
     * @return Map with camera details
     */
    @LuaFunction
    public final Map<String, Object> getInfo() {
        Map<String, Object> info = new HashMap<>();
        info.put("id", cameraId);
        info.put("x", cameraPos.getX());
        info.put("y", cameraPos.getY());
        info.put("z", cameraPos.getZ());
        info.put("active", isActive);
        info.put("yaw", yaw);
        info.put("pitch", pitch);
        info.put("viewDistance", viewDistance);
        return info;
    }
    
    /**
     * Check if camera is active
     * @return true if camera is operational
     */
    @LuaFunction
    public final boolean isActive() {
        return isActive;
    }
    
    /**
     * Enable or disable the camera
     * @param active true to enable, false to disable
     * @return success status
     */
    @LuaFunction
    public final boolean setActive(boolean active) {
        this.isActive = active;
        return true;
    }
    
    /**
     * Get camera position
     * @return Map with x, y, z coordinates
     */
    @LuaFunction
    public final Map<String, Integer> getPosition() {
        Map<String, Integer> pos = new HashMap<>();
        pos.put("x", cameraPos.getX());
        pos.put("y", cameraPos.getY());
        pos.put("z", cameraPos.getZ());
        return pos;
    }
    
    /**
     * Get camera rotation (yaw and pitch)
     * @return Map with yaw and pitch values
     */
    @LuaFunction
    public final Map<String, Float> getRotation() {
        Map<String, Float> rotation = new HashMap<>();
        rotation.put("yaw", yaw);
        rotation.put("pitch", pitch);
        return rotation;
    }
    
    /**
     * Set camera rotation
     * @param newYaw horizontal rotation (-180 to 180)
     * @param newPitch vertical rotation (-90 to 90)
     * @return success status
     */
    @LuaFunction
    public final boolean setRotation(float newYaw, float newPitch) {
        // Clamp values
        this.yaw = Math.max(-180, Math.min(180, newYaw));
        this.pitch = Math.max(-90, Math.min(90, newPitch));
        return true;
    }
    
    /**
     * Get view distance of camera
     * @return current view distance in blocks
     */
    @LuaFunction
    public final int getViewDistance() {
        return viewDistance;
    }
    
    /**
     * Set view distance
     * @param distance view distance in blocks (1-64)
     * @return success status
     */
    @LuaFunction
    public final boolean setViewDistance(int distance) {
        this.viewDistance = Math.max(1, Math.min(64, distance));
        return true;
    }
    
    /**
     * Capture current camera view
     * Returns entities and blocks in camera's field of view
     * @return Map with captured data
     */
    @LuaFunction
    public final Map<String, Object> capture() {
        if (!isActive) {
            return Collections.singletonMap("error", "Camera is not active");
        }
        
        Map<String, Object> capture = new HashMap<>();
        capture.put("timestamp", System.currentTimeMillis());
        capture.put("position", getPosition());
        capture.put("rotation", getRotation());
        
        // Scan for entities in view
        List<Map<String, Object>> entities = scanEntities();
        capture.put("entities", entities);
        capture.put("entityCount", entities.size());
        
        // Detect motion (simplified)
        capture.put("motionDetected", entities.size() > 0);
        
        return capture;
    }
    
    /**
     * Scan for entities in camera view
     * @return List of detected entities
     */
    @LuaFunction
    public final List<Map<String, Object>> scanEntities() {
        List<Map<String, Object>> entityList = new ArrayList<>();
        
        // Get entities near camera
        var entities = level.getEntitiesOfClass(
            net.minecraft.world.entity.Entity.class,
            new net.minecraft.world.phys.AABB(cameraPos).inflate(viewDistance)
        );
        
        for (var entity : entities) {
            Map<String, Object> entityData = new HashMap<>();
            entityData.put("type", entity.getType().toString());
            entityData.put("name", entity.getName().getString());
            entityData.put("x", entity.getX());
            entityData.put("y", entity.getY());
            entityData.put("z", entity.getZ());
            
            // Calculate distance from camera
            double distance = Math.sqrt(cameraPos.distSqr(entity.blockPosition()));
            entityData.put("distance", distance);
            
            // Check if entity is a player
            entityData.put("isPlayer", entity instanceof net.minecraft.world.entity.player.Player);
            
            entityList.add(entityData);
        }
        
        return entityList;
    }
    
    /**
     * Detect motion in camera view
     * @return true if motion detected
     */
    @LuaFunction
    public final boolean detectMotion() {
        return !scanEntities().isEmpty();
    }
    
    /**
     * Get light level at camera position
     * @return light level (0-15)
     */
    @LuaFunction
    public final int getLightLevel() {
        return level.getMaxLocalRawBrightness(cameraPos);
    }
    
    /**
     * Check if it's day or night
     * @return "day", "night", or "unknown"
     */
    @LuaFunction
    public final String getTimeOfDay() {
        long time = level.getDayTime() % 24000;
        if (time >= 0 && time < 12000) {
            return "day";
        } else if (time >= 12000 && time < 24000) {
            return "night";
        }
        return "unknown";
    }
    
    /**
     * Get camera status summary
     * @return Map with comprehensive status
     */
    @LuaFunction
    public final Map<String, Object> getStatus() {
        Map<String, Object> status = new HashMap<>();
        status.put("online", isActive);
        status.put("position", getPosition());
        status.put("rotation", getRotation());
        status.put("viewDistance", viewDistance);
        status.put("lightLevel", getLightLevel());
        status.put("timeOfDay", getTimeOfDay());
        status.put("entitiesInView", scanEntities().size());
        status.put("motionDetected", detectMotion());
        return status;
    }
    
    /**
     * Reset camera to default settings
     * @return success status
     */
    @LuaFunction
    public final boolean reset() {
        this.isActive = true;
        this.yaw = 0.0f;
        this.pitch = 0.0f;
        this.viewDistance = 32;
        return true;
    }
}
