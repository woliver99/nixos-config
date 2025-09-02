{ pkgs ? import <nixpkgs> {} }:

let
  ntfy-desktop = pkgs.stdenv.mkDerivation rec {
    pname = "ntfy-desktop";
    version = "2.2.0";

    src = pkgs.fetchzip {
      url = "https://github.com/aetherinox/ntfy-desktop/releases/download/${version}/ntfy-desktop-${version}-linux-amd64.zip";
      sha256 = "sha256-Hteh7AdjhYBuXMByMK3iVnsekfmoIR7JtKoOJN1p9RI=";
      # Add this line to handle the flat zip archive
      stripRoot = false;
    };

    nativeBuildInputs = [ pkgs.patchelf ];

    installPhase = ''
      # Create a directory to hold all the app's files
      mkdir -p $out/lib/ntfy-desktop

      # Copy all the extracted files into it
      cp -r ./* $out/lib/ntfy-desktop/

      # Ensure the main executable is actually executable
      chmod +x $out/lib/ntfy-desktop/ntfy-desktop

      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        $out/lib/ntfy-desktop/ntfy-desktop

      # Create a symlink in the standard bin directory
      mkdir -p $out/bin
      ln -s $out/lib/ntfy-desktop/ntfy-desktop $out/bin/ntfy-desktop
    '';

    meta = with pkgs.lib; {
      description = "Ntfy.sh desktop client";
      homepage = "https://github.comcom/aetherinox/ntfy-desktop";
      license = licenses.mit;
      platforms = platforms.linux;
    };
  };

in
pkgs.buildFHSEnv {
  name = "ntfy-desktop-fhs";
  targetPkgs = pkgs: (with pkgs; [
    ntfy-desktop
    
    glib
    nspr
    nss
    dbus
    cups
    cairo
    pango
    gtk3
    expat
    libxkbcommon
    alsa-lib
    libgbm
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libxcb
    xorg.libXrandr # Corrected from xorg.xrandr to be more specific

    # Newly added packages
    atk           # For libatk-1.0.so.0
    at-spi2-core  # For libatspi.so.0
    at-spi2-atk   # You had this, but it's good to keep
    gdk-pixbuf    # For icon/image loading
    systemd       # For the full libudev.so.1
  ]);
  runScript = "ntfy-desktop";

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cat > $out/share/applications/ntfy-desktop.desktop << EOF
    [Desktop Entry]
    Name=ntfy-desktop
    # This path remains correct as it points to the symlink we created
    Exec=${ntfy-desktop}/bin/ntfy-desktop
    Type=Application
    Terminal=false
    Icon=${ntfy-desktop}/bin/ntfy-desktop
    Comment=Ntfy.sh desktop client
    Categories=Network;
    EOF
  '';
}
