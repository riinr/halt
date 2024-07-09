let
  DEVSHELL_DIR   = getEnv "DEVSHELL_DIR"
  muslGccPath    = findExe("musl-gcc")
switch "define",         "release"
switch "opt",            "size"
switch "gcc.exe",        muslGccPath
switch "gcc.linkerexe",  muslGccPath
switch "passL",          "-s -Wl,-z,noseparate-code"
#switch "threads",        "on"
