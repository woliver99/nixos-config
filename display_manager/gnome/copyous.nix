{
  lib,
  stdenv,
  fetchzip,
  glib,
  libgda6,
  gsound,
  libsoup_3,
  gobject-introspection,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "gnome-shell-extension-copyous";
  version = "1.2.0";

  src = fetchzip {
    url = "https://github.com/boerdereinar/copyous/releases/download/v${finalAttrs.version}/copyous@boerdereinar.dev.zip";
    hash = "sha256-3yE0+F/E1/qrGGO6loaMoCzf5gtT1j964/HdytU0ePM=";
    stripRoot = false;
  };

  nativeBuildInputs = [
    glib
  ];

  buildPhase = ''
    runHook preBuild
    glib-compile-schemas --strict schemas
    runHook postBuild
  '';

  # FIX:
  # 1. We inject the 'prepend_search_path' logic into BOTH extension.js (Background) and prefs.js (Settings Window).
  # 2. We use '.out' for gobject-introspection to ensure we get the libraries, not the binaries.
  # 3. We convert static 'import Soup' to dynamic imports to prevent load-time crashes before our patch runs.
  preInstall = ''
    # Define the setup code block with the correct paths
    SETUP_CODE='import GIRepository from "gi://GIRepository"; \
    const repo = GIRepository.Repository.dup_default(); \
    repo.prepend_search_path("${gobject-introspection.out}/lib/girepository-1.0"); \
    repo.prepend_search_path("${libsoup_3}/lib/girepository-1.0"); \
    repo.prepend_search_path("${libgda6}/lib/girepository-1.0"); \
    repo.prepend_search_path("${gsound}/lib/girepository-1.0");'

    # Inject into extension.js (The main extension)
    sed -i "1i $SETUP_CODE" extension.js

    # Inject into prefs.js (The settings window)
    sed -i "1i $SETUP_CODE" prefs.js

    # Convert static Soup imports to dynamic to prevent race conditions during load
    find . -name "*.js" -exec sed -i "s|import Soup from 'gi://Soup?version=3.0';|const { default: Soup } = await import('gi://Soup?version=3.0');|g" {} +
    find . -name "*.js" -exec sed -i "s|import Soup from 'gi://Soup';|const { default: Soup } = await import('gi://Soup');|g" {} +
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/gnome-shell/extensions
    cp -r -T . $out/share/gnome-shell/extensions/copyous@boerdereinar.dev
    runHook postInstall
  '';

  passthru = {
    extensionPortalSlug = "copyous";
    extensionUuid = "copyous@boerdereinar.dev";
  };

  meta = with lib; {
    description = "Modern Clipboard Manager for GNOME";
    homepage = "https://github.com/boerdereinar/copyous";
    license = licenses.gpl3Only;
    maintainers = [ ];
    platforms = platforms.linux;
  };
})
