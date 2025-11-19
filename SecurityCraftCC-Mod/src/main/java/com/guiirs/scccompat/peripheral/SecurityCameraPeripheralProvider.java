package com.guiirs.scccompat.peripheral;

import dan200.computercraft.api.peripheral.IPeripheral;
import dan200.computercraft.api.peripheral.IPeripheralProvider;
import net.minecraft.core.BlockPos;
import net.minecraft.core.Direction;
import net.minecraft.world.level.Level;
import net.minecraftforge.common.util.LazyOptional;
import org.jetbrains.annotations.NotNull;

/**
 * Provider that registers Security Cameras as CC:Tweaked peripherals
 */
public class SecurityCameraPeripheralProvider implements IPeripheralProvider {
    
    @NotNull
    @Override
    public LazyOptional<IPeripheral> getPeripheral(@NotNull Level level, @NotNull BlockPos pos, @NotNull Direction side) {
        var blockState = level.getBlockState(pos);
        var block = blockState.getBlock();
        
        // Check if this is a SecurityCraft camera block
        String blockId = block.getDescriptionId();
        
        if (blockId.contains("security_camera") || blockId.contains("securitycraft:security_camera")) {
            // Create peripheral for this camera
            return LazyOptional.of(() -> new SecurityCameraPeripheral(level, pos));
        }
        
        return LazyOptional.empty();
    }
}
