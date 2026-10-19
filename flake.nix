{
  description = "Hugo and friends for building my personal blog";

  # Flake inputs
  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/11cb3517b3af6af300dd6c055aeda73c9bf52c48";
    nixpkgs.url = "github:NixOS/nixpkgs/26.05";

    # bring in current unstable to source one package
    #nixpkgs_unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs_unstable.url = "github:NixOS/nixpkgs/870493f9a8cb0b074ae5b411b2f232015db19a65";
  };

  # Flake outputs
  outputs = { self, nixpkgs, nixpkgs_unstable }:
    let
      # Systems supported
      systems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      # Helper to provide system-specific attributes
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          # Only TeX Live comes from unstable:
          unstable = import nixpkgs_unstable { inherit system; };
          # texEnv = inputs.unstable.legacyPackages.${system}.texlive.withPackages (ps: with ps; [
          #   scheme-medium   # or scheme-full if you want zero surprises
          #   xetex           # belt-and-suspenders to ensure the engine is present
          #   latexmk
          #   fontawesome6
          # ]);

          texEnv = unstable.texliveFull.withPackages (ps: with ps; [
            #fontawesome6
          ]);
        in f { inherit pkgs unstable texEnv; });
    in
    {
      # Development environment output
      devShells = forAllSystems ({ pkgs, unstable, texEnv }: {
        default = pkgs.mkShell {
            # The Nix packages provided in the environment
            packages = [
              pkgs.bash-completion
              pkgs.hugo
            ];

            shellHook = ''
              . ${pkgs.bash-completion}/share/bash-completion/bash_completion
            '';
          };
      });
    };
}
