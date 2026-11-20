{
  flake.modules.homeManager.libreoffice = { pkgs, ... }: {
    home.packages = with pkgs; [
      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      hunspellDicts.de_DE
      hyphenDicts.en_US
      hyphenDicts.de_DE
    ];
  };
}
