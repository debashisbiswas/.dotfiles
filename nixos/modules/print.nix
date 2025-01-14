{ pkgs, ... }:

{
  printing = {
    enable = true;
    drivers = with pkgs; [
      hplip
      brlaser
      gutenprint
    ];
  };

  avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
