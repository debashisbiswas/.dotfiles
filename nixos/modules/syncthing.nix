{ ... }:

{
  services.syncthing = {
    enable = true;
    dataDir = "/home/violet/sync";
    configDir = "/home/violet/.config/syncthing";
    user = "violet";
    group = "users";
    openDefaultPorts = true;
  };
}
