{
  inputs,
  lib,
  config,
  systemAspects,
  ...
}:
{
  options.configurations.nixos = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options = {
          system = lib.mkOption {
            type = lib.types.singleLineStr;
            readOnly = true;
            default = "x86_64-linux";
          };
          stateVersion = lib.mkOption {
            type = lib.types.singleLineStr;
            readOnly = true;
          };
          allowUnfree = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };
          module = lib.mkOption {
            type = lib.types.deferredModule;
          };
        };
      }
    );
  };

  config.flake = {
    nixosConfigurations = lib.flip lib.mapAttrs config.configurations.nixos (
      name:
      {
        module,
        system,
        allowUnfree,
        stateVersion,
        ...
      }:
      lib.nixosSystem {
        modules = [
          systemAspects.sops

          module

          {
            nixpkgs = {
              hostPlatform = system;
              config.allowUnfree = allowUnfree;
              config.allowBroken = false;
              # config.cudaSupport = true; # may cause a lot of recompilation
              # overlays = [
              #   inputs.nur.overlays.default
              #   inputs.rust-overlay.overlays.default
              # ];
            };

            nix = {
              nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; # legacy commands use same nixpkgs as flake
              registry = {
                nixpkgs.flake = inputs.nixpkgs;
              };
              channel.enable = false;
              extraOptions = ''

                warn-dirty = false
              '';
              settings = {
                download-buffer-size = 262144000; # 250 MB (250 * 1024 * 1024)
                experimental-features = [
                  "pipe-operators"
                  "nix-command"
                  "flakes"
                ];
                substituters = [
                  "https://cache.nixos.org/"
                  "https://nix-community.cachix.org"
                  "https://cache.nixos-cuda.org"
                ];
                trusted-public-keys = [
                  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                  "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
                  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                ];
              };
            };

            networking.hostName = name;

            system.stateVersion = stateVersion;
          }

          inputs.home-manager.nixosModules.home-manager

          {
            home-manager = {
              extraSpecialArgs.hostname = name;
              useUserPackages = true;
              useGlobalPkgs = true;
              users.${config.user.username} = {
                imports = [
                  config.flake.modules.homeManager.sops
                  config.configurations.homeManager.${name}.module
                ];
                home.stateVersion = stateVersion;
              };
            };
          }
        ];

        specialArgs = {
          hostname = name;
        };
      }
    );
  };
}
