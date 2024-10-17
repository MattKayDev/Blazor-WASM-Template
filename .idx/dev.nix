﻿# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.dotnet-sdk_8,
    pkgs.dotnet-sdk_6
  ];
  # Sets environment variables in the workspace
  env = {};
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "muhammad-sammy.csharp"{% if environment == "web" %}
      "rangav.vscode-thunder-client"{% endif %}
    ];{% if environment == "web" %}
    workspace = {
      # Runs when a workspace is (re)started
      onStart = {
        run-server = "dotnet watch --urls=http://localhost:3000";
      };
    };{% endif %}{% if environment == "blazor-wasm" %}
    # Enable previews and customize configuration
    previews = {
      enable = true;
      previews = {
        web = {
          command = [
            "dotnet"
            "watch"
            "--urls=http://localhost:$PORT"
          ];
          manager = "web";
        };
      };
    };{% endif %}
  };
}