{ pkgs, lib, focaltech-fingerprint, ... }:

let
  focaltech-libfprint = pkgs.stdenv.mkDerivation {
    pname = "focaltech-libfprint";
    version = "2.0.0";

    src = focaltech-fingerprint;

    nativeBuildInputs = [
      pkgs.autoPatchelfHook
      pkgs.pkg-config
      pkgs.patchelf
    ];

    buildInputs = [
      pkgs.glib
      pkgs.libgusb
      pkgs.nss
      pkgs.pixman
      pkgs.libgudev
      pkgs.stdenv.cc.cc.lib
    ];

    buildPhase = ''
      # Build the shim
      gcc -shared -fPIC -o focaltech-shim.so shim.c $(pkg-config --cflags --libs glib-2.0) -Wl,--version-script=shim.map
    '';

    installPhase = ''
      # Create necessary directories
      mkdir -p $out/lib

      # Copy the original proprietary driver
      cp libfprint-2.so.2.0.0 $out/lib/

      # Copy the shim
      cp focaltech-shim.so $out/lib/
      
      # The autoPatchelfHook will run after installPhase
      # We manually add the dependency to our shim first
      patchelf --add-needed focaltech-shim.so $out/lib/libfprint-2.so.2.0.0
    '';

    postFixup = ''
      # Ensure autoPatchelfHook correctly resolved everything
      # Ensure rpath points to $out/lib to find focaltech-shim.so
      patchelf --add-rpath $out/lib $out/lib/libfprint-2.so.2.0.0
    '';
  };
in
{
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd.override {
      libfprint = focaltech-libfprint;
    };
  };

  # Prevent autosuspend which breaks the device
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="2808", ATTR{idProduct}=="a658", ATTR{power/control}="on", ATTR{power/autosuspend}="-1"
  '';

  # Allow the unfree driver to be used
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "focaltech-libfprint"
  ];
}
