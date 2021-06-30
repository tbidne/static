{
  description = "static assets flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        defaultPackage = with pkgs; stdenv.mkDerivation {
          name = "static-assets";
          src = ./.;
          buildInputs = [ ];
          installPhase = ''
            mkdir -p $out/share/icons
            ln -s $src/custom_icons/element.svg $out/share/icons/element.svg
            ln -s $src/custom_icons/mattermost.svg $out/share/icons/mattermost.svg
            ln -s $src/custom_icons/slack.svg $out/share/icons/slack.svg
          '';
        };

        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.nixpkgs-fmt ];
        };
      }
    );
}
