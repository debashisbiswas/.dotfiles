{ pkgs, ... }:

{
  boot = {
    # I'm disabling this for now as I can't figure out the hybrid GPU situation -
    # enabling both integrated and dedicated graphics in the BIOS copmlicates things,
    # causing severe visual issues with hardware accelerated applications on Hyprland.
    # I'll restrict everything to the dGPU for now.

    # To get this to work again in the future, re-enable the BIOS option for both
    # integrated and dedicated graphics, or use another dedicated card for passthrough.

    # initrd.kernelModules = [
    #   "vfio_pci"
    #   "vfio"
    #   "vfio_iommu_type1"
    #
    #   # Not clear how this part interacts with the rest of the config
    #   # after merging
    #   "i915"
    #   "amdgpu"
    # ];

    kernelParams = [
      "intel_iommu=on"
    ];
    # RX 580 graphics and audio
    # ++ lib.optional cfg.enable "vfio-pci.ids=1002:67df,1002:aaf0";
  };

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
    pciutils
  ];
}
