{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # flutter
  ] ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
    cocoapods
  ];
}
