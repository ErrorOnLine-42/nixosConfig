{config, pkgs, lib, stable, ...}:
{
  zramSwap = {
    enable = true;
    memoryPercent = 20 ;
    priority = 180;
  };
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
    "vm.swappiness" = 200;
  };
}
