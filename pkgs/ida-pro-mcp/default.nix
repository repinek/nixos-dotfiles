{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "ida-pro-mcp";
  version = "0-unstable-2026-07-30";

  src = fetchFromGitHub {
    owner = "mrexodia";
    repo = "ida-pro-mcp";
    rev = "f82e6e2517a161b77e738951c3071cd446480ba0";
    hash = "sha256-nSmPuDEr/g58P/bM05XINCzg8ukvfJH097vOlCKScEw=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/ida-pro-mcp
    cp -r src/ida_pro_mcp/ida_mcp.py src/ida_pro_mcp/ida_mcp $out/lib/ida-pro-mcp/

    runHook postInstall
  '';

  meta = with lib; {
    description = "AI-powered reverse engineering assistant that bridges IDA Pro with language models through MCP.";
    homepage = "https://github.com/mrexodia/ida-pro-mcp";
    license = licenses.mit;
    platforms = ["x86_64-linux"];
  };
}
