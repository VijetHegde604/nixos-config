{ pkgs, lib, focaltech-fingerprint, settings, ... }:

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
      pkgs.gusb
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
      mkdir -p $out/lib $out/include $out/lib/pkgconfig

      # Copy the original proprietary driver
      cp libfprint-2.so.2.0.0 $out/lib/
      ln -s libfprint-2.so.2.0.0 $out/lib/libfprint-2.so
      ln -s libfprint-2.so.2.0.0 $out/lib/libfprint-2.so.2

      # Copy the shim
      cp focaltech-shim.so $out/lib/
      
      # Copy headers and pkgconfig from the original libfprint
      cp -r ${pkgs.libfprint}/include/* $out/include/
      cp ${pkgs.libfprint}/lib/pkgconfig/libfprint-2.pc $out/lib/pkgconfig/
      
      # Substitute the nix store path of libfprint with our shim's out path
      sed -i "s|${pkgs.libfprint}|$out|g" $out/lib/pkgconfig/libfprint-2.pc
      
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
lib.mkIf (settings.fingerprint or false) {
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
