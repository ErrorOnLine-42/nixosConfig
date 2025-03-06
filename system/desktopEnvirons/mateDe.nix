{config, pkgs, lib, stable, ...}:{
  services.xserver = {
    enable = true;
    desktopManager.mate.enable = true;
    desktopManager.mate.enableWaylandSession = true;
    displayManager.sddm.enable = true;
  };
}
