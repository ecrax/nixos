# currently uses: https://github.com/oxalica/rust-overlay
# alternative is fenix: https://github.com/nix-community/fenix
{
  flake.modules.homeManager.rust = { config, pkgs, ... }: {
    home = {
      sessionPath = [
        "${config.home.homeDirectory}/.cargo/bin"
      ];
      packages = with pkgs; [
        # rustup
        # cargo
        # rustc
        # rust-bin.stable.latest.default
        # TODO: https://www.ashleyarthur.co.uk/posts/2024/worklog_sept_nix_bindgen_again/
        (rust-bin.selectLatestNightlyWith (
          toolchain:
          toolchain.default.override {
            extensions = [
              "rust-src"
              "rust-analyzer" # optional: puts a matching rust-analyzer on PATH
            ];
          }
        ))
      ];
    };
  };
}
