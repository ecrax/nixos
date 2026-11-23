{ inputs, ... }: {
  flake.modules.nixos.nix-registry = {
    nix.registry.dev.flake = inputs.self;
  };
}
