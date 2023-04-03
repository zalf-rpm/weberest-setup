{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/21.11.tar.gz") {} }:

let
  my-python = pkgs.python39Full;
  python-with-my-packages = my-python.withPackages (p: with p; [
    pycapnp
    schedule
  ]);
in
pkgs.mkShell {
  buildInputs = [
    python-with-my-packages
    pkgs.which
    pkgs.htop
    pkgs.zlib
    pkgs.clojure
    pkgs.boot
    pkgs.jdk17_headless
    pkgs.maven
    pkgs.git
    pkgs.capnproto
    pkgs.pkg-config
  ];

  shellHook = ''
    PYTHONPATH=${python-with-my-packages}/${python-with-my-packages.sitePackages}
    #  echo hello
  '';

  #MY_ENVIRONMENT_VARIABLE = "world";

}