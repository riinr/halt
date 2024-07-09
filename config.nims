let
  DEVSHELL_DIR   = getEnv "DEVSHELL_DIR"
  muslGccPath    = findExe("musl-gcc")
switch "opt",            "size"
switch "gcc.exe",        muslGccPath
switch "gcc.linkerexe",  muslGccPath
switch "passL",          "-s -Wl,-z,noseparate-code"
switch "outdir",      "bin"
