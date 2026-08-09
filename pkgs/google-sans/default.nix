{
  lib,
  stdenvNoCC,
  installFonts,
}:
stdenvNoCC.mkDerivation {
  pname = "google-sans";
  version = "0-unstable-2026-08-03";

  src = ./Google_Sans;

  nativeBuildInputs = [installFonts];

  postPatch = ''
    rm -f OFL.txt README.txt
  '';

  meta = with lib; {
    description = "Google Sans is the current generation of Google’s brand typeface, with wide language support.";
    homepage = "https://fonts.google.com/specimen/Google+Sans";
    license = licenses.ofl;
    platforms = ["x86_64-linux"];
  };
}
