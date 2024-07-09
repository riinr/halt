{pkgs, ...}:
{ 
  
  files.direnv.enable = true;
  files.gitignore.enable = true;
  # copy contents from https://github.com/github/gitignore
  # to our .gitignore
  files.gitignore.template."Global/Archives"         = true;
  files.gitignore.template."Global/Backup"           = true;
  files.gitignore.template."Global/Diff"             = true;
  files.gitignore.template."Global/Vim"              = true;
  files.gitignore.template."Global/VisualStudioCode" = true;
  files.gitignore.template."Nim"                     = true;
  files.gitignore.template."VisualStudio"            = true;
  files.gitignore.pattern.".direnv"                  = true;

  # install a packages
  packages = [
    "nim"
    "nimble"
    "binutils"
    "gcc"
    "pkg-config"
    pkgs.musl.dev
  ];

  env = [{ name = "PKG_CONFIG_PATH"; eval="$DEVSHELL_DIR/lib/pkgconfig/"; }];
}
