{ pkgs, ... }:

{
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    hyprlock.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;

    # gtk portal for file pickers
    # https://wiki.hyprland.org/Hypr-Ecosystem/xdg-desktop-portal-hyprland/
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
