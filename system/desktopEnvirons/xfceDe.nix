{config, pkgs, lib, stable, ...}:{
  services = {
    displayManager.sddm.enable = true;
    xserver = {
      enable = true;
      desktopManager.xfce.enable = true;
      desktopManager.xfce.enableXfwm = true;
    };
  };
  programs = {
    thunar.enable = true;
    xfconf.enable = true;
  };
}
