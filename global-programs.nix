{ config, pkgs, ... }:

let
  vars = import ./vars.nix;
in
{
  programs = {
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
        theme = "candy";
      };
    };

    tmux = {
      enable = true;
      historyLimit = 10000;
      terminal = "screen-256color";
      keyMode = "vi";
      extraConfig = builtins.readFile ./custom/tmux.conf;
    };

    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      defaultEditor = true;
      withPython3 = true;
      withNodeJs = true;
      configure = {
        customRC = ''
          " luafile ${./custom/nvim/init.lua}
          ${builtins.readFile ./custom/vim.vim}
        '';

        packages.plugins = with pkgs.vimPlugins; {
          start = [
            vim-packer
            nvim-lspconfig
            nvim-lsputils
            coc-nvim
            coc-json
            coc-pyright
            coc-docker
            coc-sh
            coc-yaml
            coc-markdownlint
            coc-rust-analyzer
            coc-lua
            papercolor-theme
            lsp-colors-nvim
            lightline-vim
            lightline-bufferline
            vim-lightline-coc
            vim-nix
            neo-tree-nvim
            vim-buffergator
            nvim-cmp
            cmp-nvim-ultisnips
            cmp-nvim-lsp
            cmp-nvim-lsp-document-symbol
            gitsigns-nvim
            vim-terraform
            papercolor-theme
            python-syntax
            vim-devicons
          ];
          opt = [ ];
        };
      };
    };

    # Workaround for badly themed GTK apps on Wayland
    dconf.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    nix-ld.enable = true;
  };
}
