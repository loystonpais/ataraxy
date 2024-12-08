{
  description = "A discord bot written in rust";

  inputs = { nixpkgs.url = "nixpkgs/nixos-24.11"; };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;

      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });

      packages = forAllSystems (system: {
        default = import ./default.nix { pkgs = nixpkgsFor.${system}; };
      });

      devShells = forAllSystems (system: {
        default = import ./shell.nix { pkgs = nixpkgsFor.${system}; };
      });

      nixosModules.default = { config, lib, pkgs }: {
        options.programs = {
          ataraxy-discord-bot = {
            enable = lib.mkEnableOption "enables ataraxy discord bot";
          };
        };

        config = lib.mkIf config.programs.ataraxy-discord-bot.enable {
          systemd.services.ataraxy-discord-bot = 
          let 
            system = builtins.currentSystem;
            pkg = pkgs.callPackage ./default.nix { inherit pkgs; };
          in
          {
            enable = true;

            serviceConfig = {
              ExecStart = "${pkg}/bin/ataraxy ";
              EnvironmentFile =
                config.sops.secrets.ataraxy_environment_file.path;
              Restart = "on-failure";
              TimeoutStartSec = 5;
              RestartSec = 2;
            };

            wantedBy = [ "multi-user.target" "network-online.target" ];

          };
        };
      };

    in {
      inherit packages;
      inherit devShells;
      inherit nixosModules;
    };

}
