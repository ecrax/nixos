{
  flake.modules.homeManager.tmux =
    { lib, pkgs, ... }:
    let
      bindings = {
        root = {
          # Alt-arrows switch panes, Shift-arrows and Alt-H/L switch windows
          M-Left = "select-pane -L";
          M-Right = "select-pane -R";
          M-Up = "select-pane -U";
          M-Down = "select-pane -D";
          S-Left = "previous-window";
          S-Right = "next-window";
          M-H = "previous-window";
          M-L = "next-window";
        };
        copy-mode-vi = {
          v = "send-keys -X begin-selection";
          C-v = "send-keys -X rectangle-toggle";
          y = "send-keys -X copy-selection-and-cancel";
        };
      };

      mkBinds =
        table: keys:
        lib.mapAttrsToList (key: cmd: "bind-key -T ${table} ${key} ${cmd}") keys;
    in
    {
      programs.tmux = {
        enable = true;
        terminal = "tmux-256color";
        prefix = "C-Space"; # also unbinds C-b and binds send-prefix
        mouse = true;
        keyMode = "vi";
        baseIndex = 1; # windows and panes start at 1
        sensibleOnTop = true; # replaces the tmux-sensible @plugin line
        customPaneNavigationAndResize = true; # prefix + h/j/k/l, plus H/J/K/L to resize

        plugins = with pkgs.tmuxPlugins; [
          vim-tmux-navigator
          yank
          {
            plugin = resurrect;
            extraConfig = ''
              set -g @resurrect-capture-pane-contents "on" # also restore visible pane text
            '';
          }
          {
            plugin = continuum; # keep this last, it hooks into status-right and catppuccin overwrites that
            extraConfig = ''
              set -g @continuum-restore "on"        # restore automatically when the tmux server starts
              set -g @continuum-save-interval "10"  # minutes
            '';
          }
        ];

        extraConfig = ''
          set -sa terminal-overrides ",xterm*:Tc"
          set -g renumber-windows on

          ${lib.concatStringsSep "\n" (
            mkBinds "root" bindings.root ++ mkBinds "copy-mode-vi" bindings.copy-mode-vi
          )}

          bind '"' split-window -v -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"
        '';
      };

      programs.zsh.initContent = lib.mkBefore ''
        # start tmux in every interactive shell, except inside tmux, VS Code, or with NO_TMUX set
        if [[ -o interactive && -z "$TMUX" && -z "$NO_TMUX" && "$TERM_PROGRAM" != vscode ]] \
           && command -v tmux >/dev/null; then
          exec tmux new-session -A -s main
        fi
      '';
    };
}
