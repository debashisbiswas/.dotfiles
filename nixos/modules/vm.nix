{ pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  users.users.violet.extraGroups = [ "libvirtd" "kvm" ];
  environment.systemPackages = with pkgs; [
    virt-manager
    qemu
  ];
}
