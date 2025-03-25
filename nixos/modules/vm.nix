{ pkgs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;

        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
      };
    };
  };

  users.users.violet.extraGroups = [ "libvirtd" "kvm" ];
  environment.systemPackages = with pkgs; [
    virt-manager
    qemu
  ];
}
