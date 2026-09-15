{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "zaps-cool-photon-theme";
  version = "0-unstable-2026-09-11";

  src = fetchFromGitHub {
    owner = "zapSNH";
    repo = "zapsCoolPhotonTheme";
    rev = "3ba62661610a60c9b5d0553069e185dcb7ba6c03";
    hash = "sha256-IO/iocchmr6tuSlqjhyAtCkR7jIiKQJhWMARDzk0BoE=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r . $out/

    runHook postInstall
  '';

  meta = with lib; {
    description = "party like it's firefox 87!";
    homepage = "https://github.com/zapSNH/zapsCoolPhotonTheme";
    license = licenses.gpl3;
    platforms = ["x86_64-linux"];
  };
}
