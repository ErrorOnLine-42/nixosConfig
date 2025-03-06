{config, pkgs, lib, stable, ... }:{
  services.cinnamon.apps.enable = true;
  services.xserver = {
    enable = true;
    desktopManager.cinnamon = {
	enable = true;
	extraGSettingsOverridePackages = [pkgs.mutter];
	extraGSettingsOverrides = ''
	  [org.gnome.mutter]
	  experimental-features=['variable-refresh-rate', 'scale-monitor-framebuffer']
	'';
    };
    displayManager.sddm.enable = true;
  };
}
