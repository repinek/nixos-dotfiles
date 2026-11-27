desktopFile: name: {
  "applications/${desktopFile}".text = ''
    [Desktop Entry]
    Type=Application
    Name=${name}
    Hidden=true
  '';
}
