# nix develop dev#python -c zsh

{ inputs, ... }: {
  perSystem = { pkgs, system, ... }: {
    devShells = {
      python = pkgs.mkShell {
        packages = with pkgs; [
          python3
          uv
          ruff
        ];
      };

      rust =
        let
          fenix = inputs.fenix.packages.${system};
        in
        pkgs.mkShell {
          packages = [
            (fenix.complete.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
            ])
            fenix.rust-analyzer-nightly
          ];
        };
    };
  };
}
