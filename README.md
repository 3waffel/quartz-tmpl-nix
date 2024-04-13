# Quartz Template Nix

This repository provides a nix lib for building quartz sites with default config.

## Usage

- Include the module in your flake inputs
  ```nix
  {
      inputs.quartz-tmpl-nix.url = "github:3waffel/quartz-tmpl-nix";
  }
  ```

- Use the lib in your package outputs
  ```nix
  {
      # ...
      example = quartz-tmpl-nix.lib.${system}.mkQuartz {
          name = "example";
          content = ./content;
          extraConfig = {
            pageTitle = "Quartz Template Nix";
            baseUrl = "example.com";
          };
      };
  }
  ```

- Build the package
  ```
  nix build .#example
  ```
