{config, pkgs, lib, stable, ... }:

let
    gstPlugins = with pkgs.gst_all_1; [
        gst-libav
        gst-plugins-bad
        gst-plugins-base
        gst-plugins-good
        gst-plugins-ugly
        gst-vaapi
        gstreamer
    ];

    sessionVariablesForGst =
    lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [ gst-plugins-good gst-plugins-bad gst-plugins-ugly ]);

    enablePipewire = {
        services.pulseaudio.enable = false;
        services.pipewire = {
            enable = true;
            pulse.enable = true;
        };
    };

in {

    imports = [ enablePipewire ];

    environment = {
        sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = sessionVariablesForGst;
        systemPackages = ( with pkgs; [
            wl-clipboard
            wl-clipboard-x11
        ])
        ++ (gstPlugins);
    };

    fonts = {
        enableDefaultPackages = true;
        fontDir.enable = true;
        packages = with pkgs; [
            # (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" "IntelOneMono" ];})
            nerd-fonts.hack
            nerd-fonts.jetbrains-mono
            inter
        ];
    };

    programs = {
        # firefox.enable = lib.mkDefault true;
        # firefox.preferences."widget.use-xdg-desktop-portal.file-picker" = 1;
        # firefox.package = pkgs.firefox-bin;
        kdeconnect.enable = true;
    };

    hardware = {
        logitech.wireless.enable = true;
        bluetooth = {
            enable = true;
            powerOnBoot = true;
        };
        steam-hardware.enable = true;
    };

    services = {
        printing = {
            enable = true;
            drivers = [ pkgs.hplipWithPlugin ];
        };
    };
}
