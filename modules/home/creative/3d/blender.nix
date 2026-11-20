# builds the latest blender release
# for more versions build Blender-Launcher-V2 (https://github.com/Victor-IX/Blender-Launcher-V2) manually
{
  flake.modules.homeManager.blender = { pkgs, ... }: {
    home.packages = with pkgs; [
      (blender.override {
        config.cudaSupport = true;
        config.rocmSupport = false;
      }) # rocmSupport enables HIP
    ];
  };
}
