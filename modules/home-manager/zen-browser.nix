{ inputs, pkgs, ... }:
let
  zenPackage = inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default;
  zenWithPdf = zenPackage.overrideAttrs (old: {
    desktopItem = old.desktopItem.override (itemOld: {
      mimeTypes = (itemOld.mimeTypes or [ ]) ++ [
        "application/pdf"
        "application/x-pdf"
        "application/x-bzpdf"
        "application/x-gzpdf"
      ];
    });
  });
in
{
  home.packages = [
    zenWithPdf
  ];

  home.sessionVariables = {
    DEFAULT_BROWSER = "zen";
    BROWSER = "zen";
  };
}
