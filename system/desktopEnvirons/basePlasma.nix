{config, pkgs, lib, stable, ...}:{

    environment.systemPackages = ( with pkgs; [ vlc dconf-editor]);
    programs.dconf.enable = true;

}
