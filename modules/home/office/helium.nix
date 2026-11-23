{ homeAspects, inputs, ... }: {
  flake.modules.homeManager.helium =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = [ inputs.helium-flake.homeModules.default  ];

      programs.helium  = {
        enable = true;
        # Flags - Command-line arguments always passed to Helium
        flags = [
          # "--disable-gpu"
          # "--ozone-platform-hint=auto"
        ];

        # Policies - Written to /etc/chromium/policies/managed/helium-nixos.json
        # Also written to /etc/helium/policies/managed/ for future compatibility
        policies = {
          "PasswordManagerEnabled" = false;
          "SpellcheckEnabled" = true;
          "SpellcheckLanguage" = [ "en-US" "de-DE" ];
        };
      };
    };
}
