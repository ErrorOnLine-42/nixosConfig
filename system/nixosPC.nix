{config, pkgs, lib, stable, ... }:
let
    gnomeDe = ./desktopEnvirons/gnomeDe.nix;
    plasma6De = ./desktopEnvirons/plasma6De.nix;
    plasma5De = ./desktopEnvirons/plasma5De.nix;
    commonDe = ./desktopEnvirons/commonDe.nix;
    base = ./modules/base.nix;
    zramStuff = ./modules/zramStuff.nix;
    silentBoot = ./modules/silentBoot.nix;
    gaming = ./modules/gaming.nix;
    amdgpuMod = ./modules/xserverAmdgpu.nix;
    cinnamonDe = ./desktopEnvirons/cinnamonDe.nix;
    cosmicDe = ./desktopEnvirons/cosmicDe.nix;

    apps = {
        environment = {
            systemPackages = with pkgs; [
                eza
                gnome-system-monitor
                google-chrome
                killall
                neovim
                pwvucontrol
                ripgrep
                rustup
                tree-sitter
                yt-dlp
                wineWowPackages.staging
                winetricks
                firefox
                # libreoffice-fresh
                # wootility
                # (chromium.override {enableWideVine = true;})
            ] ++ ( with stable; [
                # librewolf
            ]);
        };
    };

    virtManager = {
        programs.virt-manager.enable = true;
        users.groups.libvirtd.members = ["victor"];
        virtualisation = {
            spiceUSBRedirection.enable = true;
            libvirtd = { enable = true; };
        };
    };

in {

    imports = [
        # amdgpuMod
        # cinnamonDe
        # cosmicDe
        # gnomeDe
        # silentBoot
        # zramStuff
        apps
        base
        commonDe
        gaming
        plasma6De
        virtManager
    ];

    boot = {
        loader = { efi.efiSysMountPoint = "/boot"; };
        kernelParams = [ "video=3840x2160@240" ];
    };

    fileSystems = {
        "/" = { device = "/dev/disk/by-label/nixos"; fsType="bcachefs"; };
        "/boot" = { device = "/dev/disk/by-label/efilinux"; fsType="vfat";};
        "/bulk" = { device = "/dev/disk/by-label/bulk"; fsType="bcachefs";};
    };

    hardware = {
        enableRedistributableFirmware = true;
        cpu.amd.updateMicrocode = true;
        amdgpu.initrd.enable = true;
        enableAllFirmware = true;
        wooting.enable = true;
    };

    networking = {
        hostName = "nixosPC";
        firewall.enable = false;
    };

    users.users = {
        victor = {
            description = "victor";
            extraGroups = [ "networkmanager" "wheel" "input" "realtime" "audio" "video" "render" ];
            createHome = false;
            isNormalUser = true;
            initialPassword = "123";
        };
    };

    security = {
        rtkit.enable = true;
        sudo.extraRules = [{
            users = ["victor"];
            commands = [{
                command = "ALL";
                options = ["NOPASSWD"];
            }];
        }];
    };

    services = {
        avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;
        };
    };
}
