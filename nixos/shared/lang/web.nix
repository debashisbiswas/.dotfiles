{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    nodejs
    astro-language-server
    emmet-language-server
    prettierd
    svelte-language-server
    tailwindcss-language-server
    typescript-language-server
    vtsls
    yarn-berry
    vscode-langservers-extracted
  ];
}