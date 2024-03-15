{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  env = {
    SHELLCHECK_OPTS = "-e SC2002";
  };

  # https://devenv.sh/packages/
  packages = with pkgs; [ git ];

  # https://devenv.sh/scripts/
  scripts.hello.exec = "echo hello from $GREET";

  enterShell = ''
  '';

  # https://devenv.sh/languages/
  languages.nix.enable = true;

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
    shellcheck.enable = true;
    actionlint.enable = true;
    hadolint.enable = true;
  };

  # https://devenv.sh/processes/
  # processes.ping.exec = "ping example.com";

  # See full reference at https://devenv.sh/reference/options/
}
