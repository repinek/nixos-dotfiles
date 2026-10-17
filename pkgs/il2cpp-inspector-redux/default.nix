{
  lib,
  stdenv,
  fetchzip,
  makeWrapper,
  autoPatchelfHook,
  gcc,
  dotnetCorePackages,
}:
stdenv.mkDerivation {
  pname = "il2cpp-inspector-redux";
  version = "2026.02";

  src = fetchzip {
    url = "https://github.com/LukeFZ/Il2CppInspectorRedux/releases/download/2026.2/Il2CppInspectorRedux.CLI-linux-x64.zip";
    hash = "sha256-x8kGwOzea6TX/mOf/CXvwDWd9gw0JUlQs53zE44/Rnk=";
    stripRoot = true;
  };

  meta = {
    description = "Continuation of Il2CppInspector - A powerful automated tool for reverse engineering Unity IL2CPP binaries.";
    homepage = "https://github.com/LukeFZ/Il2CppInspectorRedux";
    license = lib.licenses.agpl3Only;
    mainProgram = "il2cpp-inspector";
    platforms = ["x86_64-linux"];
  };

  nativeBuildInputs = [makeWrapper autoPatchelfHook];
  buildInputs = [gcc.cc.lib];

  dontBuild = true;
  dontStrip = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/il2cpp-inspector-redux $out/bin
    cp -r . $out/lib/il2cpp-inspector-redux
    chmod +x $out/lib/il2cpp-inspector-redux/Il2CppInspector.Redux.CLI

    makeWrapper \
      $out/lib/il2cpp-inspector-redux/Il2CppInspector.Redux.CLI \
      $out/bin/il2cpp-inspector \
      --set DOTNET_ROOT "${dotnetCorePackages.aspnetcore_10_0}/share/dotnet"

    runHook postInstall
  '';
}
