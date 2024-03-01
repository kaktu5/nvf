{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.dag) entryAnywhere;

  cfg = config.vim.lsp;
in {
  config = mkIf (cfg.enable && cfg.lightbulb.enable) {
    vim = {
      startPlugins = ["nvim-lightbulb"];

      luaConfigRC.lightbulb = entryAnywhere ''
        vim.api.nvim_command('autocmd CursorHold,CursorHoldI * lua require\'nvim-lightbulb\'.update_lightbulb()')

        -- Enable trouble diagnostics viewer
        require'nvim-lightbulb'.setup()
      '';
    };
  };
}
