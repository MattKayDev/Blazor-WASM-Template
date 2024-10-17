﻿{ pkgs, environment ? "blazor-wasm", ... }: {
  packages = [ pkgs.dotnet-sdk_8 pkgs.j2cli pkgs.nixfmt ];
  bootstrap = ''
    export HOME=/home/user
    dotnet new ${environment} -o "$WS_NAME"
    mkdir -p "$WS_NAME/.idx/"
    cp ${./icon.png} "$WS_NAME/.idx/icon.png"
    environment=${environment} j2 ${./devNix.j2} -o "$WS_NAME"/.idx/dev.nix
    nixfmt "$WS_NAME"/.idx/dev.nix
    cp -rf ${./.}/${environment}/* "$WS_NAME"
    chmod -R +w "$WS_NAME"
    mv "$WS_NAME" "$out"
  '';
}