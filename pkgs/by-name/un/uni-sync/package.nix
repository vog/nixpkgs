{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  libudev-zero,
}:
rustPlatform.buildRustPackage {
  pname = "uni-sync";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "EightB1ts";
    repo = "uni-sync";
    rev = "ca349942c06fabcc028ce24e79fc6ce7c758452b";
    hash = "sha256-K2zX3rKtTaKO6q76xlxX+rDLL0gEsJ2l8x/s1vsp+ZQ=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libudev-zero ];

  patches = [
    ./config_path.patch
    ./ignore_read-only_filesystem.patch
  ];

  cargoHash = "sha256-Qb0TPpYGDjsqHkI4B8QRz5c9rqZ+H98YjOg5K++zpBg=";

  meta = with lib; {
    description = "Synchronization tool for Lian Li Uni Controllers";
    homepage = "https://github.com/EightB1ts/uni-sync";
    license = licenses.mit;
    maintainers = with maintainers; [ yunfachi ];
    mainProgram = "uni-sync";
  };
}
