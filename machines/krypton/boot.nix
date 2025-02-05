{ pkgs, config, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    extraModprobeConfig = ''
      options iwlmvm  power_scheme=1
      options iwlwifi power_save=0
    '';
    kernelModules = [ "v4l2loopback" ];
    initrd = {
      kernelModules = [ "kvm-amd" ];
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
    };
  };
}
