{
  description = "Flipper Zero Embedded Toolchain x86_64-linux Binaries";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux = rec {
      flipperzero-toolchain-bin =
        nixpkgs.legacyPackages.x86_64-linux.callPackage ./default.nix { };
      default = flipperzero-toolchain-bin;
    };
  };
}
