{ ... }:

{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "violet" ];

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
