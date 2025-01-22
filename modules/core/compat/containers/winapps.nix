{
  inputs,
  pkgs,
  ...
}: {
  environment.variables = {
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };
  environment.systemPackages = [
    inputs.winapps.packages."${pkgs.system}".winapps
    inputs.winapps.packages."${pkgs.system}".winapps-launcher
    pkgs.virtiofsd
  ];
  services.qemuGuest.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;
  users.groups.libvirtd.members = ["kareem"];
}
