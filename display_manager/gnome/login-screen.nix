{ pkgs, ... }:

let
  # Get the username of the person running the build
  username = builtins.getEnv "SUDO_USER";
  
  # Path to that user's personal monitor configuration
  userMonitorsFile = "/home/${username}/.config/monitors.xml";

  # Read the content of the file at build time
  monitorsContent =
    if username != "" && builtins.pathExists userMonitorsFile
    then builtins.readFile userMonitorsFile
    else "";
  
  # ✅ Safely write the XML content to a static file in the Nix store
  monitorsFileInStore = pkgs.writeText "monitors.xml" monitorsContent;

in
{
  system.activationScripts.gdm_config = {
    deps = [ "specialfs" ];
    # Only run if a monitors.xml was actually found
    text = pkgs.lib.mkIf (monitorsContent != "") ''
      GDM_CONF_PATH=/run/gdm/.config
      MONITORS_CONF_FILE="$GDM_CONF_PATH/monitors.xml"
      
      mkdir -p "$GDM_CONF_PATH"
      
      # ✅ Safely copy the file from the Nix store instead of embedding its content
      cp -f "${monitorsFileInStore}" "$MONITORS_CONF_FILE"
      
      # Set the correct ownership and permissions
      chown gdm:gdm  "$MONITORS_CONF_FILE"
      chmod 644 "$MONITORS_CONF_FILE"
    '';
  };
}
