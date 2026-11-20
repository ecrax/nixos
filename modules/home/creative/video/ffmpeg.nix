{
  flake.modules.homeManager.ffmpeg = { pkgs, ... }: {
    home.packages = with pkgs; [
      (
        (ffmpeg-full.override {
          withUnfree = true; # Allow unfree dependencies (for Nvidia features notably)
          withMetal = false; # Use Metal API on Mac. Unfree and requires manual downloading of files
          withMfx = false; # Hardware acceleration via the deprecated intel-media-sdk/libmfx. Use oneVPL instead (enabled by default) from Intel's oneAPI.
          withSmallBuild = false; # Prefer binary size to performance.
          withDebug = false; # Build using debug options
        }).overrideAttrs
          (_: {
            doCheck = false;
          })
      ) # skip checks after build
    ];
  };
}
