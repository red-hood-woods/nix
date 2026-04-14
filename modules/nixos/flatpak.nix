# modules/system/flatpak.nix
{ inputs, lib, ... }: {
  services.flatpak = {
    enable = true;
    remotes = lib.mkOptionDefault [{
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }];
    packages = [
      "app.twintaillauncher.ttl"
    ];
  };
}