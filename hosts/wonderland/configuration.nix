{ config, pkgs, lib, unstable-pkgs, ... }:

{
  imports = [
    ../common/default.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "wonderland";
  networking.extraHosts = "127.0.0.1 wonderland";

  boot.initrd.kernelModules = [ "i915" ];

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-vaapi-driver
    libvdpau-va-gl
    intel-compute-runtime
  ];

  hardware.enableAllFirmware = true;
}