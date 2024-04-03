{ pkgs, lib, ... }:

let
  dslrWebcamConfContent = ''
    alias dslr-webcam v4l2loopback
    options v4l2loopback exclusive_caps=1 max_buffers=2 card_label="DSLR" video_nr=10
  '';

  dslrUdevRule = ''ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="04a9", ATTR{idProduct}=="317b", RUN+="/bin/sh -c 'gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -f v4l2 /dev/video10'"'';
in
{
  # Ensure your system configuration includes these options:

  environment.systemPackages = with pkgs; [
    # Ensure you have gphoto2 and ffmpeg available
    gphoto2
    ffmpeg
  ];

  boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];

  # Load v4l2loopback module with the required options
  boot.extraModprobeConfig = dslrWebcamConfContent;

  # Udev rule for DSLR camera
  services.udev.extraRules = dslrUdevRule;
}
