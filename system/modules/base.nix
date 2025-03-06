{config, pkgs, stable, lib, ... }: let

    enabledKernModules = [
        "nvme"
        # "btrfs"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
        # "dm-cache-default"
    ];

in {

    system.stateVersion = "24.11";
    systemd.extraConfig = "DefaultTimeoutStopSec=5s";
    time.timeZone = "America/New_York";

    networking = {
        networkmanager.enable = true;
        # useDHCP = lib.mkDefault true;
        useDHCP = false;
    };

    nix.settings = {
        auto-optimise-store = true;
        experimental-features = ["nix-command" "flakes"];
    };

    nixpkgs = {
        config.allowUnfree = true;
        hostPlatform = lib.mkDefault "x86_64-linux";
    };

    programs = {
        ssh.askPassword = lib.mkForce "no";
    };

    services = {
        fstrim.enable = true;
        # openssh.enable = true;
        # openssh.settings.PermitRootLogin = "no";
    };

    boot = {
        loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = false;
            grub.device = "nodev";
            grub.efiSupport = true;
        };
        kernel.sysctl = { "kernel.sysrq" = 1; };
        initrd.availableKernelModules = enabledKernModules;
        supportedFilesystems = [ "btrfs" "bcachefs" "xfs" "ntfs" "exfat" "ext4"];
        kernelParams = [ "nowatchdog" ];

        kernelPackages = pkgs.linuxPackages_latest; # linuxPackages -rt_latest _latest _zen
    };

    environment = {
        variables.EDITOR = "nvim";
        systemPackages = ( with pkgs; [ git rsync tmux neovim vim ]);
    };

    i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
            C_IDENTIFICATION = "en_US.UTF-8"; C_MONETARY = "en_US.UTF-8"; C_NUMERIC = "en_US.UTF-8";
            C_TELEPHONE = "en_US.UTF-8"; LC_ADDRESS = "en_US.UTF-8"; LC_MEASUREMENT = "en_US.UTF-8";
            LC_NAME = "en_US.UTF-8"; LC_PAPER = "en_US.UTF-8"; LC_TIME = "en_US.UTF-8";
        };
    };
}
