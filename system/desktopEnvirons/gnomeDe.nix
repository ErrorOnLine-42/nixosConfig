{config, pkgs, lib, stable, ...} : {

  environment = {
    systemPackages = ( with pkgs; [
      mpv
      vlc
      gnome-tweaks
      # gnomeExtensions.hide-top-bar
      # gnomeExtensions.displays-adjustments
      # gnomeExtensions.brightness-control-using-ddcutil
      dconf-editor
    ddcutil
    ]);
  };

  programs.kdeconnect.package = pkgs.gnomeExtensions.gsconnect;

  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregatedIcons = pkgs.buildEnv {
      name = "system-icons";
      paths = with pkgs; [
        #libsForQt5.breeze-qt5  # for plasma
        gnome-themes-extra
      ];
      pathsToLink = [ "/share/icons" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = [ "/share/fonts" ];
    };
  in {
    "/usr/share/icons" = mkRoSymBind "${aggregatedIcons}/share/icons";
    "/usr/local/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
    ];
  };

  services = {
    flatpak.enable = true;
    xserver = {
      enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [pkgs.mutter];
        extraGSettingsOverrides = ''
            [org.gnome.mutter]
            experimental-features=[ 'variable-refresh-rate' ]
        '';
      };
      displayManager.gdm.enable = true;
    };
  };
}
