# Original source is
# https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/id/ida-free/package.nix
# All rights belong to it
{
  autoPatchelfHook,
  cairo,
  dbus,
  requireFile,
  fontconfig,
  freetype,
  glib,
  gtk3,
  lib,
  libdrm,
  libGL,
  libkrb5,
  libsecret,
  libunwind,
  libxkbcommon,
  makeWrapper,
  openssl,
  perl,
  python3,
  stdenv,
  libxcb-wm,
  libxcb-render-util,
  libxcb-keysyms,
  libxcb-image,
  libxcb-cursor,
  libxrender,
  libxi,
  libxext,
  libxau,
  libx11,
  libsm,
  libice,
  libxcb,
  zlib,
  # I don't think I need hex patches
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "ida-pro";
  version = "9.2";

  # Use nix-store --add-fixed to add files
  src = requireFile {
    name = "ida-pro_92_x64linux.run";
    sha256 = "aadd0f8ae972b84f94f2a974834abf1619f3bd933b3b4d8275f9c50008d05ae1";
    message = "Unknown source";
  };

  keygen = requireFile {
    name = "keygen-v2.py";
    sha256 = "efa29b12888b5b8ef7c8c2bea1dac1b24f56fe137752f436c8ef88bfdf4fe89b";
    message = "Unknown source";
  };

  nativeBuildInputs = [
    makeWrapper
    autoPatchelfHook
    perl
    python3
  ];

  # We just get a runfile in $src, so no need to unpack it.
  dontUnpack = true;

  # Add everything to the RPATH, in case IDA decides to dlopen things.
  runtimeDependencies = [
    cairo
    dbus
    fontconfig
    freetype
    glib
    gtk3
    libdrm
    libGL
    libkrb5
    libsecret
    libunwind
    libxkbcommon
    openssl
    stdenv.cc.cc
    libice
    libsm
    libx11
    libxau
    libxcb
    libxext
    libxi
    libxrender
    libxcb-image
    libxcb-keysyms
    libxcb-render-util
    libxcb-wm
    libxcb-cursor
    zlib
  ];
  buildInputs = finalAttrs.runtimeDependencies;

  # IDA comes with its own Qt6, some dependencies are missing in the installer.
  autoPatchelfIgnoreMissingDeps = [
    "libQt6Network.so.6"
    "libQt6EglFSDeviceIntegration.so.6"
    "libQt6WaylandEglClientHwIntegration.so.6"
    "libQt6WaylandCompositor.so.6"
    "libQt6WlShellIntegration.so.6"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib $out/opt
    mkdir -p $out/share/applications

    # IDA depends on quite some things extracted by the runfile, so first extract everything
    # into $out/opt, then remove the unnecessary files and directories.
    IDADIR=$out/opt/ida-pro-${finalAttrs.version}

    # The installer doesn't honor `--prefix` in all places,
    # thus needing to set `HOME` here.
    HOME=$out

    # Invoke the installer with the dynamic loader directly, avoiding the need
    # to copy it to fix permissions and patch the executable.
    $(cat $NIX_CC/nix-support/dynamic-linker) $src \
      --mode unattended --prefix $IDADIR

    # Yeah, I have no clue what is this
    (cd $IDADIR && python3 $keygen --patch --apply && python3 $keygen --license)
    rm -f $IDADIR/*.bak

    # Copy the exported libraries to the output.
    cp $IDADIR/libida.so $out/lib

    # Some libraries come with the installer.
    addAutoPatchelfSearchPath $IDADIR

    # Wrap the ida executable to set QT_PLUGIN_PATH
    wrapProgram $IDADIR/ida \
      --prefix QT_PLUGIN_PATH : $IDADIR/plugins/platforms
    ln -s $IDADIR/ida  $out/bin/ida
    ln -s $IDADIR/idat $out/bin/idat

    # runtimeDependencies don't get added to non-executables, and openssl is needed
    #  for cloud decompilation
    patchelf --add-needed libcrypto.so $IDADIR/libida.so

    # .desktop files here too
    if [ -d "$out/.local/share" ]; then
      cp -r $out/.local/share/* $out/share/
      rm -rf $out/.local
    fi

    runHook postInstall
  '';

  meta = {
    description = "A powerful disassembler, decompiler and a versatile debugger. In one tool";
    homepage = "https://hex-rays.com/ida-pro/";
    changelog = "https://hex-rays.com/products/ida/news/";
    license = lib.licenses.unfreeRedistributable;
    mainProgram = "ida";
    platforms = ["x86_64-linux"];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})
