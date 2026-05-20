{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      font-dir = "./assets/fonts"; # needs to be a string, otherwise this will point to flake root in the nix store
    in
    {
      # script to set up font dir, should be run in project root
      # adapted from https://github.com/tuda-typst/tuda-typst-templates/blob/e0b6ca8778c778ed205dbaa43279e0289aa25dee/assets/fonts/download_fonts.sh
      packages.${system}.download-fonts = pkgs.writeShellScriptBin "download-fonts" ''
        mkdir -p ${font-dir}
        cd ${font-dir}

        ${pkgs.lib.getExe pkgs.wget} https://mirrors.ctan.org/fonts/roboto.zip
        unzip -o roboto.zip
        mv roboto/opentype roboto_
        rm -r roboto
        mv roboto_ roboto
        rm roboto/RobotoCondensed*
        rm roboto/RobotoSerif_Condensed*
        rm roboto/RobotoSerif*
        rm roboto.zip

        # xcharta font
        ${pkgs.lib.getExe pkgs.wget} http://mirrors.ctan.org/fonts/xcharter.zip
        unzip -o xcharter.zip
        mv xcharter/opentype xcharter_
        rm -r xcharter
        mv xcharter_ xcharter
        rm xcharter.zip
      '';

      devShells.${system}.default = pkgs.mkShellNoCC {
        # interactive packages
        packages = [ ];

        # build dependencies
        inputsFrom = [ ];

        shellHook = ''
          export TYPST_FONT_PATHS=${font-dir}:${pkgs.font-awesome}
        '';
      };
      formatter.${system} = pkgs.nixfmt;
    };
}
