{
  self,
  ...
} @ inputs: let
  upkgs = inputs.unstable.legacyPackages.x86_64-linux;

  nodePkgs = upkgs.callPackages ./nodePackages/override.nix {};
in {

  "angular" = nodePkgs."@angular/cli";
}
