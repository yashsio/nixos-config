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

  nixos-switch = "sudo nixos-rebuild switch --flake ${nixConfigPath}#host";
  nixos-test = "sudo nixos-rebuild test --flake ${nixConfigPath}#host";
  nixos-boot = "sudo nixos-rebuild boot --flake ${nixConfigPath}#host";
  switch-vm = "sudo nixos-rebuild switch --flake ${nixConfigPath}#vm";
  test-vm = "sudo nixos-rebuild test --flake ${nixConfigPath}#vm";
  boot-vm = "sudo nixos-rebuild boot --flake ${nixConfigPath}#vm";
  cleanup = "sudo nix-collect-garbage -d";
}

