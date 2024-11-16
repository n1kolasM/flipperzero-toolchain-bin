{ stdenv, lib, fetchFromGitHub, fetchurl, zlib, libnsl, libtirpc, openssl_1_1
, libxcrypt, ncurses, autoPatchelfHook }:
let
  libnsl_1_3_0 = libnsl.overrideAttrs (final: prev: rec {
    version = "1.3.0";
    src = fetchFromGitHub {
      owner = "thkukuk";
      repo = prev.pname;
      rev = "v${version}";
      sha256 = "sha256-hRfpKfHrk6gzOg0Va02FDyixuWUqsvmPfcXARWKRXrU=";
    };
  });

in stdenv.mkDerivation rec {
  pname = "flipperzero-toolchain-bin";
  version = "40";

  src = fetchurl {
    url =
      "https://update.flipperzero.one/builds/toolchain/gcc-arm-none-eabi-12.3-x86_64-linux-flipper-${version}.tar.gz";
    hash = "sha256-Iw4/+VxV1eK8loVmtIdPAXZd6yJuu6AXX4nzSeLgIHE=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [
    libnsl_1_3_0
    libtirpc
    libxcrypt
    ncurses
    openssl_1_1
    stdenv.cc.cc.lib
    zlib
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/toolchain/x86_64-linux
    cp -R . $out/toolchain/x86_64-linux
  '';

  meta = with lib; {
    homepage = "https://github.com/flipperdevices/flipperzero-toolchain";
    description = "Flipper Zero Embedded Toolchain x86_64-linux Binaries";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
  };
}
