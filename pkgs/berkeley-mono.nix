{
  lib,
  requireFile,
  unzip,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "berkeley-mono";
  version = "1009";

  src = requireFile rec {
    name = "${finalAttrs.pname}.zip";
    sha256 = "19pbq5nqpi81920ymfkqhj9zvpgai8hslqavq238yfk094vfn7s8";
    message = ''
      You need to have berkeley mono installed.

      Get it as a zip then run these commands on it to put it into the nix store.

      mv \$PWD/berkeley-mono-typeface.zip \$PWD/${name}
      nix-prefetch-url --type sha256 file://\$PWD/${name}

      Alternatively, if you don't want it, remove this from `pkgs/berkeley-mono.nix`

      berkeley-mono = pkgs.callPackage ./berkeley-mono.nix {};
    '';
  };

  outputs = [
    "out"
    "web"
    "variable"
    "variableweb"
  ];

  nativeBuildInputs = [
    unzip
  ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    install -m444 -Dt $out/share/fonts/truetype/berkeley-mono */berkeley-mono/TTF/*.ttf
    install -m444 -Dt $out/share/fonts/opentype/berkeley-mono */berkeley-mono/OTF/*.otf
    install -m444 -Dt $web/share/fonts/webfonts/berkeley-mono */berkeley-mono/WEB/*.woff2
    install -m444 -Dt $variable/share/fonts/truetype/berkeley-mono */berkeley-mono-variable/TTF/*.ttf
    install -m444 -Dt $variableweb/share/fonts/webfonts/berkeley-mono */berkeley-mono-variable/WEB/*.woff2
  '';

  meta = {
    description = "Berkeley Mono Typeface";
    longDescription = "…";
    homepage = "https://berkeleygraphics.com/typefaces/berkeley-mono";
    license = lib.licenses.unfree;
    platforms = lib.platforms.all;
  };
})
