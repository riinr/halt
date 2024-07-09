{
  description = "Dev Environment";

  inputs.dsf.url     = "github:cruel-intentions/devshell-files";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
  inputs.dsf.inputs.nixpkgs.follows = "nixpkgs";

  outputs = inputs: inputs.dsf.lib.shell inputs [
    ./project.nix  # import nix module
  ];
}
