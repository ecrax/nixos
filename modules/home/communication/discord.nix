{
  flake.modules.homeManager.discord = {
    programs.discord = {
      enable = true;
      settings = {
        DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = false;
        SKIP_HOST_UPDATE = true;
        SKIP_MODULE_UPDATE = true;
      };
    };

    # this disables home manager restart error
    # possibly does not work on fresh install?
    # xdg.configFile."discord/settings.json".enable = false;
  };
}
