{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    quartz-src = {
      url = "github:jackyzha0/quartz?rev=4d73b8289d16fde3271e748b84fd7f90a56a8899";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    quartz-src,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        config = import ./config.nix;
      in {
        packages = {
          example = self.lib.${system}.mkQuartz {
            name = "example";
            content = builtins.path {
              path = ./.;
              filter = path: type:
                builtins.elem (/. + path) [
                  ./README.md
                  ./index.md
                ];
            };
            extraConfig = {
              pageTitle = "Example Title";
            };
          };
          default = self.packages.${system}.example;
        };

        lib.mkQuartz = {
          name,
          content,
          configFile ? ./quartz.config.ts,
          layoutFile ? ./quartz.layout.ts,
          extraConfig ? {},
        }: let
          quartz = pkgs.buildNpmPackage {
            name = "quartz";
            npmDepsHash = "sha256-BkNRsEhVBIO3rOVitVsh/dPTCGI6FRALLSf+57TqdYc=";
            src = quartz-src;
            dontNpmBuild = true;
            env.QUARTZ_CONFIG = builtins.readFile (
              (pkgs.formats.json {}).generate "extra-config"
              (config.defaultConfig // extraConfig)
            );

            installPhase = ''
              runHook preInstall
              npmInstallHook
              cd $out/lib/node_modules/@jackyzha0/quartz
              rm -rf content
              cp -r ${content} content
              cp ${configFile} quartz.config.ts
              cp ${layoutFile} quartz.layout.ts
              $out/bin/quartz build
              mv ./public $out/public
              runHook postInstall
            '';
          };
        in
          pkgs.stdenv.mkDerivation {
            inherit name;
            phases = ["installPhase"];
            installPhase = ''
              cp -r ${quartz}/public $out
            '';
          };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            direnv
          ];
        };
      }
    );
}
