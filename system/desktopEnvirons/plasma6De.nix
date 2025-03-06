{config, lib, pkgs, stable, ...}:{

  imports = [ ./basePlasma.nix ];

  services = {
    desktopManager.plasma6.enable = true;
  };

}
