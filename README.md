# Contents

- [PC Configurations](#pc-configurations)
    - [NixOS](#nixos)
    - [Homelab](#homelab)

# PC Configurations
This section lists all configuration details for both my main pc running NixOS and my secondary pc running my home lab server.
## NixOS
Nixos Install guide: \
https://www.youtube.com/watch?v=2QjzI5dXwDY \
https://www.youtube.com/watch?v=Wn-6Ls-yJAQ

https://vimjoyer.com/nixmap/#focus=nixos-flake

## leo todo
- purge all unused/different software
- rename poseidon to something seomthing wsl
- move from vscodium to vscode
- install zed
- test config on full vm
- install zen/helium browser
  - with netflix support
- update some aspects/configs based on jonathans
- maybe laptop/darwin

## NixOS todo
Incomplete list of software I plan to add:
- cuda devel
- BlenderLauncher
- Zed
- ImageMagick
- Kdenlive
- Krita
- darktable
- Inkscape
- VLC
- Rufus
- Wireshark
- aesprite
- vscodium currently does not load any extensions or user settings
- also plasma manager meta shift 1,2,3 etc dont work
- configure wireless networks (including eduroam)
- nixvim and helix need language configuration

Also sometimes nh os switch failes:
- systemctl restart systemd-logind
- also get home manager logs: sudo systemctl status home-manager-jonathan.service

## NixOS install
- follow https://nixos.org/manual/nixos/stable/#sec-installation
- clone nixos-config into /mnt/tmp
- update hardware config for host
- add experimental features to installer nix config
    - mkdir -p ~/.config/nix
    - echo "extra-experimental-features = nix-command flakes pipe-operators" >> ~/.config/nix/nix.conf
- nixos-install --flake '/mnt/tmp#nixos'


## Homelab
    - proxmox
        - configure gpu passthrough
    - debianvm
        - vaultwarden
        - teamspeak
        - cloudflare tunnel/tailscale


Cloudflare is for Applications you use, website, wiki, photo management

Tailscale is for Management, Proxmox server, terminal, remote desktop, Portainer.

# NixOS

# PC Configurations
## Primary
### Horus
### Ptah
## Secondary
## Laptop
### Apesh
