package com.guiirs.scccompat;

import com.guiirs.scccompat.integration.CCIntegration;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.event.lifecycle.FMLCommonSetupEvent;
import net.minecraftforge.fml.javafmlmod.FMLJavaModLoadingContext;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Mod("scccompat")
public class SecurityCraftCCCompat {
    
    public static final String MOD_ID = "scccompat";
    public static final Logger LOGGER = LogManager.getLogger();
    
    public SecurityCraftCCCompat() {
        FMLJavaModLoadingContext.get().getModEventBus().addListener(this::setup);
        LOGGER.info("SecurityCraft CC:Tweaked Compatibility Mod Loading...");
    }
    
    private void setup(final FMLCommonSetupEvent event) {
        LOGGER.info("Registering SecurityCraft cameras as CC:Tweaked peripherals...");
        CCIntegration.register(event);
        LOGGER.info("SecurityCraft CC:Tweaked Compatibility initialized!");
        LOGGER.info("Security Cameras can now be used as CC:Tweaked peripherals!");
    }
}
