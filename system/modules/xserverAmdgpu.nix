{config, pkgs, lib, stable, ...}:
{
  services.xserver = {
	displayManager.lightdm.enable = false;
	displayManager.startx.enable = true;
    enable = true;
    videoDrivers = ["amdgpu"];
    deviceSection = ''
      Driver "amdgpu"
      Option "VariableRefresh" "true"
      # Option "EnablePageFlip" "true"
      # Option "TearFree" "true"
    '';
  };
}
