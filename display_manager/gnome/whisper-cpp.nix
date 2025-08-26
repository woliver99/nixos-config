# /etc/nixos/whisper-cpp.nix
{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "whisper-cpp-vulkan";
  version = "unstable-2025-08-24"; # You can set this to today's date

  # This tells Nix exactly which version of the code to get.
  # Replace the rev and sha256 with the values from Step 1.
  src = pkgs.fetchgit {
    url = "https://github.com/ggml-org/whisper.cpp.git";
    rev = "7745fcf32846006128f16de429cfe1677c963b30";
    sha256 = "01r02k6y8rq5zy5vi636978339labgaqlc3cislkligpznd5l02w";
  };

  # These are the tools needed to build the software.
  nativeBuildInputs = with pkgs; [
    cmake
    git
    vulkan-loader
    vulkan-headers
    shaderc
  ];

  # This passes the -DGGML_VULKAN=ON flag to cmake.
  cmakeFlags = [
    "-DGGML_VULKAN=ON"
  ];

  # Don't try to run the default "check" phase.
  doCheck = false;
}
