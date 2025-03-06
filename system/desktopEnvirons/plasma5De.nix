{config, pkgs, lib, stable, ...}:{

  imports = [ ./basePlasma.nix ];
  services.xserver.desktopManager.plasma5.enable = true;

}
