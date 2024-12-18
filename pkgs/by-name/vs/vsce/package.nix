{
  lib,
  stdenv,
  buildNpmPackage,
  fetchFromGitHub,
  pkg-config,
  libsecret,
  darwin,
  python3,
  testers,
  vsce,
}:

buildNpmPackage rec {
  pname = "vsce";
  version = "3.1.0";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "vscode-vsce";
    rev = "v${version}";
    hash = "sha256-k2jeYeDLpSVw3puiOqlrtQ1a156OV1Er/TqdJuJ+578=";
  };

  npmDepsHash = "sha256-k6LdGCpVoBNpHe4z7NrS0T/gcB1EQBvBxGAM3zo+AAo=";

  postPatch = ''
    substituteInPlace package.json --replace '"version": "0.0.0"' '"version": "${version}"'
  '';

  nativeBuildInputs = [
    pkg-config
    python3
  ];

  buildInputs =
    [ libsecret ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin (
      with darwin.apple_sdk.frameworks;
      [
        AppKit
        Security
      ]
    );

  makeCacheWritable = true;
  npmFlags = [ "--legacy-peer-deps" ];

  passthru.tests.version = testers.testVersion {
    package = vsce;
  };

  meta = with lib; {
    homepage = "https://github.com/microsoft/vscode-vsce";
    description = "Visual Studio Code Extension Manager";
    maintainers = with maintainers; [ aaronjheng ];
    license = licenses.mit;
    mainProgram = "vsce";
  };
}
