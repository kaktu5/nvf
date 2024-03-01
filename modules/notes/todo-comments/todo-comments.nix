{lib, ...}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) str;
  inherit (lib.nvim.binds) mkMappingOption;
in {
  options.vim.notes.todo-comments = {
    enable = mkEnableOption "todo-comments: highlight and search for todo comments like TODO, HACK, BUG in your code base";

    patterns = {
      highlight = mkOption {
        type = str;
        default = ''[[.*<(KEYWORDS)(\([^\)]*\))?:]]'';
        description = "vim regex pattern used for highlighting comments";
      };

      search = mkOption {
        type = str;
        default = ''[[\b(KEYWORDS)(\([^\)]*\))?:]]'';
        description = "ripgrep regex pattern used for searching comments";
      };
    };

    mappings = {
      quickFix = mkMappingOption "Open Todo-s in a quickfix list" "<leader>tdq";
      telescope = mkMappingOption "Open Todo-s in telescope" "<leader>tds";
      trouble = mkMappingOption "Open Todo-s in Trouble" "<leader>tdt";
    };
  };
}
