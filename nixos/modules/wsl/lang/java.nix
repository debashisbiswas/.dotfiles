{ pkgs, ... }:

let
  jdk_with_zscaler = pkgs.jdk.override {
    cacert = pkgs.runCommand "zscalercacert" { } ''
      mkdir -p $out/etc/ssl/certs
      cat ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt \
        ${./ZScalerRoot.crt} > $out/etc/ssl/certs/ca-bundle.crt
    '';
  };
in
{
  home.packages = with pkgs; [ maven ];

  programs.java = {
    enable = true;
    package = jdk_with_zscaler;
  };
}
