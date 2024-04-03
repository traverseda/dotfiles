{ pkgs, lib, ... }:

let
  wifiUdevRule = ''
    ACTION=="add", SUBSYSTEM=="net", TAGS!="virtual", ENV{DEVTYPE}=="wlan", TAG+="virtual", RUN+="${pkgs.iw}/bin/iw dev %k interface add %k_ap type station"
  '';
in
{
  environment.systemPackages = with pkgs; [
    iw
  ];

  services.udev.extraRules = wifiUdevRule;
}

