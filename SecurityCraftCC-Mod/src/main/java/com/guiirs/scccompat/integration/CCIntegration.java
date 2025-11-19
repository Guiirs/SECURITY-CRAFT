package com.guiirs.scccompat.integration;

import com.guiirs.scccompat.peripheral.SecurityCameraPeripheralProvider;
import dan200.computercraft.api.ComputerCraftAPI;
import net.minecraftforge.fml.event.lifecycle.FMLCommonSetupEvent;

/**
 * Handles integration with CC:Tweaked API
 */
public class CCIntegration {
    
    public static void register(FMLCommonSetupEvent event) {
        event.enqueueWork(() -> {
            // Register our peripheral provider
            ComputerCraftAPI.registerPeripheralProvider(new SecurityCameraPeripheralProvider());
        });
    }
}
