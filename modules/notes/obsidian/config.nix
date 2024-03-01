{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.dag) entryAnywhere;
  inherit (lib.nvim.binds) pushDownDefault;

  cfg = config.vim.notes.obsidian;
  auto = config.vim.autocomplete;
in {
  config = mkIf cfg.enable {
    vim = {
      startPlugins = [
        "obsidian-nvim"
        "vim-markdown"
        "tabular"
      ];

      binds.whichKey.register = pushDownDefault {
        "<leader>o" = "+Notes";
      };

      luaConfigRC.obsidian = entryAnywhere ''
        require("obsidian").setup({
          dir = "${cfg.dir}",
          completion = {
            nvim_cmp = ${
          if (auto.type == "nvim-cmp")
          then "true"
          else "false"
        }
          },
          daily_notes = {
            folder = ${
          if (cfg.daily-notes.folder == "")
          then "nil,"
          else "'${cfg.daily-notes.folder}',"
        }
            date_format = ${
          if (cfg.daily-notes.date-format == "")
          then "nil,"
          else "'${cfg.daily-notes.date-format}',"
        }
          }
        })
      '';
    };
  };
}
