{
  lib,
  stdenv,
  fetchzip,
  glib,
  libgda6,
  gsound,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "gnome-shell-extension-copyous";
  version = "1.1.3";

  src = fetchzip {
    url = "https://github.com/boerdereinar/copyous/releases/download/v${finalAttrs.version}/copyous@boerdereinar.dev.zip";
    hash = "sha256-8LRj+wYKgMWJZYu0ViahatNEkiscCkPZEoLoitNoGbc=";
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

  # FIX: GNOME 49 (GIRepository 3.0) requires an instance of the Repository 
  # to set search paths. The static method 'GIRepository.Repository.prepend_search_path' 
  # was removed. We use 'dup_default()' to get the handle.
  preInstall = ''
    sed -i '1i import GIRepository from "gi://GIRepository"; const repo = GIRepository.Repository.dup_default(); repo.prepend_search_path("${libgda6}/lib/girepository-1.0"); repo.prepend_search_path("${gsound}/lib/girepository-1.0");' extension.js
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
