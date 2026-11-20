{ inputs, config, ... }: {
    flake.modules.nixos.wsl = {
        imports = [ inputs.NixOS-WSL.nixosModules.wsl ];

        wsl.enable = true;
        wsl.defaultUser = config.user.username;

        # WSL pre-creates /run/user/1000 as root; NixOS-WSL skips user-runtime-dir@
        # when it exists, so nothing fixes the owner and pam_systemd rejects it.
        systemd.services.wsl-fix-runtime-dir = {
          description = "Fix owner of WSL-created /run/user/1000";
          wantedBy = [ "user@1000.service" ];
          before = [ "user-runtime-dir@1000.service" "user@1000.service" ];
          serviceConfig.Type = "oneshot";
          script = ''
            if [ -d /run/user/1000 ]; then
              chown ${config.user.username}: /run/user/1000
              chmod 0700 /run/user/1000
            fi
          '';
        };
    };
}
