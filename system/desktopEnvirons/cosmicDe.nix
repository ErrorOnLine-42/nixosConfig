{config, lib, pkgs, stable, ...}:{
    environment.systemPackages = ( with pkgs; [ vlc dconf-editor]);
    services = {
        desktopManager.cosmic.enable = true;
        displayManager.cosmic-greeter.enable = true;
    };
}
