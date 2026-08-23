{
  bash,
  lib,
  stdenvNoCC,
}:

let
  mkEnv =
    {
      name ? "env",
      PS1 ? ''\[\033[1;32m\][${name}:\w]\$\[\033[0m\] '',
      preferLocalBuild ? true,
      allowSubstitutes ? false,
      shell ? bash,
      packages,
      nativeBuildInputs ? [ shell ] ++ packages,
    }:
    stdenvNoCC.mkDerivation {
      inherit
        name
        preferLocalBuild
        allowSubstitutes
        nativeBuildInputs
        ;
      phases = [ "buildPhase" ];
      buildPhase = ''
        install -Dm555 /dev/stdin $out <<EOF
        #!${bash}/bin/bash
        set -Cefu
        $(
          unset OLDPWD PWD SHLVL
          unset TEMP TEMPDIR TMP TMPDIR
          unset NIX_BUILD_TOP
          unset OCAMLFIND_DESTDIR
          unset buildPhase phases
          unset out outputs
          set -o posix
          export
        )
        export PS1=${lib.escapeShellArg PS1}
        [ \$# = 0 ] || exec "\$@"
        exec ${lib.escapeShellArg (lib.getExe shell)} -i
        EOF
      '';
    };
in

mkEnv
