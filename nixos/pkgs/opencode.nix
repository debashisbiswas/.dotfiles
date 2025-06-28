{
  lib,
  stdenv,
  fetchurl,
  unzip,
}:

let
  inherit (stdenv.hostPlatform) system;
  throwSystem = throw "Unsupported system: ${system}";

  plat =
    {
      x86_64-linux = "linux-x64";
      aarch64-linux = "linux-arm64";
      x86_64-darwin = "darwin-x64";
      aarch64-darwin = "darwin-arm64";
    }
    .${system} or throwSystem;

  hash =
    {
      x86_64-linux = "sha256-i6zmBE03fJbsU7aUxl5BsfXHNJcFrz+wMTII584xvS0=";
      aarch64-linux = "sha256-VZMgC2aGITVYuQSmKcu7mRnGLY3g7JWMz1v4m/9s/6w=";
      x86_64-darwin = "sha256-bNh5GqJqZxXR0W67pkS4+u6e2A7RoDfcFhSUniel5HM=";
      aarch64-darwin = "sha256-GInZWaBLldYp6E27NXKY851/88b3PnSp2AuLUpFrobA=";
    }
    .${system} or throwSystem;
in
stdenv.mkDerivation rec {
  pname = "opencode";
  version = "0.1.157";

  src = fetchurl {
    url = "https://github.com/sst/opencode/releases/download/v${version}/opencode-${plat}.zip";
    inherit hash;
  };

  nativeBuildInputs = [ unzip ];

  unpackPhase = ''
    runHook preUnpack
    unzip $src
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp opencode $out/bin/
    chmod +x $out/bin/opencode
    runHook postInstall
  '';

  meta = with lib; {
    description = "AI coding agent, built for the terminal";
    homepage = "https://github.com/sst/opencode";
    license = licenses.mit;
    maintainers = [ ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    mainProgram = "opencode";
  };
}
