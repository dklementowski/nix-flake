{ configs, pkgs, ... }:

let
  vars = ../../vars.nix;
in {
  # Configure shell basics
  environment = {
    shells = with pkgs; [ zsh ];

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };

    variables.EDITOR = "nvim";

    systemPackages = with pkgs; [
      killall
      tree
      ripgrep
      wl-clipboard

      wget
      curl

      git
      ncdu
      btop
      neofetch
    ];
  };

  programs = {
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "candy";
      };
    };

    tmux = {
      enable = true;
      historyLimit = 10000;
      terminal = "screen-256color";
      keyMode = "vi";
      extraConfig = builtins.readFile ./dotfiles/tmux.conf;
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
          " luafile ${./dotfiles/nvim/init.lua}
          ${builtins.readFile ./dotfiles/vim.vim}
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

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
