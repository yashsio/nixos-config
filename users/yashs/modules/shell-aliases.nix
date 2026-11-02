# shell-aliases.nix
{ config, ... }:

let
  nixConfigPath = "${config.home.homeDirectory}/nixos-config";
in
{
  ga = "git add";
  gc = "git commit";
  gco = "git checkout";
  gcp = "git cherry-pick";
  gdiff = "git diff";
  gl = "git prettylog";
  gp = "git push";
  gs = "git status";
  gt = "git tag";

  jd = "jj desc";
  jf = "jj git fetch";
  jn = "jj new";
  jp = "jj git push";
  js = "jj st";

  ff = "fastfetch"; 

  nrs = "sudo nixos-rebuild switch --flake ${nixConfigPath}";
  nrt = "sudo nixos-rebuild test --flake ${nixConfigPath}";
  nrb = "sudo nixos-rebuild boot --flake ${nixConfigPath}";
  nrd = "sudo nixos-rebuild dry-build --flake ${nixConfigPath}";

  nfc = "nix flake check ${nixConfigPath} --all-systems --no-build";

  cleanup = "sudo nix-collect-garbage -d";
}

