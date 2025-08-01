{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  boost,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "mqtt_cpp";
  version = "13.2.2";

  src = fetchFromGitHub {
    owner = "redboltz";
    repo = "mqtt_cpp";
    rev = "v${finalAttrs.version}";
    hash = "sha256-L1XscNriCBZF3PB2QXhA08s9aUqoQ1SwE9wnHHCUHvg=";
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = [ boost ];

  meta = with lib; {
    description = "MQTT client/server for C++14 based on Boost.Asio";
    homepage = "https://github.com/redboltz/mqtt_cpp";
    license = licenses.boost;
    maintainers = with maintainers; [ spalf ];
    platforms = platforms.unix;
  };
})
