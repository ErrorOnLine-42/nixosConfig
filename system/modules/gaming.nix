{config, pkgs, lib, stable, system, ...}: 
let

    steamModule = {
        nixpkgs.config.packageOverrides = pkgs: {
            steam = pkgs.steam.override {
                extraPkgs = pkgs: with pkgs; [
                    xorg.libXcursor xorg.libXi xorg.libXinerama xorg.libXScrnSaver
                    libpng libpulseaudio libvorbis stdenv.cc.cc.lib
                    libkrb5 keyutils mesa vulkan-loader
                    libglvnd gamescope gamescope-wsi mangohud
                ];
            };
        };
        programs.steam = {
            enable = true;
            dedicatedServer.openFirewall = true;
            remotePlay.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
            protontricks.enable = true;
        };
        environment.systemPackages = with pkgs; [ gamescope gamescope-wsi mangohud protonup-qt ];
    };

    emulatorsModule = {
        environment.systemPackages = with pkgs; [
            dolphin-emu
            (cemu.overrideAttrs (finalAttrs: previousAttrs: {
                owner = "NixOS";
                repo = "nixpkgs";
                rev = "2641d97cbf96e0b4caf1733edc47cf1298de0960";
                sha256 = "sha256-LgIpAXGXjte4FOubSJO6d4wc0imJkPYlPnyC9Sg+zAA=";
            }))
        ];
    };


    enableAmdvlk = {
        environment.variables = { 
            # VK_ICD_FILENAMES="/run/opengl-driver-32/share/vulkan/icd.d/amd_icd32.json:/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json"; 
            # VK_ICD_FILENAMES="/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json:/run/opengl-driver-32/share/vulkan/icd.d/amd_icd32.json"; 

            # VK_ICD_FILENAMES="/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json"; 
        };
        hardware.graphics.extraPackages = with pkgs; [ amdvlk ];
        hardware.graphics.extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };

in { 
    imports = [
        # steamModule
        # emulatorsModule
        # enableAmdvlk
    ];

    environment = {
        variables = {
            MESA_VK_WSI_PRESENT_MODE = "fifo"; # mailbox immediate fifo relaxed
            ENABLE_GAMESCOPE_WSI=1;
            DXVK_HDR=1;
        };
        systemPackages = with pkgs; [ steam gamescope mangohud protonup-qt ] ++ (with pkgs; [ gamescope-wsi]);
    };
    hardware = {
        graphics = {
            enable = true;
            enable32Bit = true;
            extraPackages = with pkgs; [ mesa libglvnd vulkan-loader ];
            extraPackages32 = with pkgs; [ driversi686Linux.mesa ];
            # extraPackages32 = with unstable; [ driversi686Linux.amdvlk ];
        };
        steam-hardware.enable = true;
    };
}
