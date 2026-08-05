# repinek's NixOS Packages
Standatalone flake providing reusable Nix packages.

## Usage

```nix
inputs.repinek-pkgs.url = "path:./pkgs";
```

## Packages

- **google-sans** - Google Sans is the current generation of Google’s brand typeface, with wide language support.  
Name: `google-sans` | Version: `0-unstable-2026-08-03` | 🌐 [Homepage](https://fonts.google.com/specimen/Google+Sans) | 📦 [Source](./google-sans/default.nix) | License: `OFL-1.1`

- **ida-pro** - A powerful disassembler, decompiler and a versatile debugger. In one tool.  
Name: `ida-pro` | Version: `9.2` | 🌐 [Homepage](https://hex-rays.com/ida-pro/) | 📦 [Source](./ida-pro/default.nix) | License: `unfree`  
    > **NOTE:** No source included, the files must be obtained externally and added to the Nix store manually via `nix-store --add-fixed`.   

- **ida-pro-mcp** - AI-powered reverse engineering assistant that bridges IDA Pro with language models through MCP.  
Name: `ida-pro-mcp` | Version: `0-unstable-2026-07-30` | 🌐 [Homepage](https://github.com/mrexodia/ida-pro-mcp) | 📦 [Source](./ida-pro-mcp/default.nix) | License: `MIT`  

