{
  flake.modules.homeManager.bun =
    { pkgs, ... }:
    {
      programs.bun = {
        enable = true;
        settings = {
          telemetry = false;
        };
      };
    };
}
