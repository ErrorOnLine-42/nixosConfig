{config, pkgs, lib, stable, ...}:
{
  boot = {
    initrd = { verbose = false; };
    consoleLogLevel = 0;
    plymouth.enable = true;
    kernelParams = [ "quiet" "udev.log_level=3" "systemd.show_status=auto" ];
  };
}
