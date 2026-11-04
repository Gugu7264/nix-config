{
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # Web
      "text/html" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/about" = "zen.desktop";
      "x-scheme-handler/unknown" = "zen.desktop";
      "x-scheme-handler/chrome" = "zen.desktop";
      "application/x-extension-htm" = "zen.desktop";
      "application/x-extension-html" = "zen.desktop";
      "application/x-extension-shtml" = "zen.desktop";
      "application/xhtml+xml" = "zen.desktop";
      "application/x-extension-xhtml" = "zen.desktop";
      "application/x-extension-xht" = "zen.desktop";

      # PDF & documents
      "application/pdf" = "zen.desktop";
      "application/x-pdf" = "zen.desktop";
      "application/x-bzpdf" = "zen.desktop";
      "application/x-gzpdf" = "zen.desktop";
      "application/x-ext-pdf" = "zen.desktop";
      "application/vnd.comicbook+zip" = "dms-open.desktop";
      "application/vnd.comicbook-rar" = "dms-open.desktop";

      # Communications & tools
      "x-scheme-handler/sgnl" = "signal.desktop";
      "x-scheme-handler/signalcaptcha" = "signal.desktop";
      "x-scheme-handler/slack" = "slack.desktop";
      "x-scheme-handler/jetbrains" = "jetbrainsd.desktop";
      "x-scheme-handler/rpi-imager" = "com.raspberrypi.rpi-imager-uri-handler.desktop";
      "x-scheme-handler/calendar" = "dms-open.desktop";
      "x-scheme-handler/discord-1530285876263915591" = "discord-1530285876263915591.desktop";
      "x-scheme-handler/recube" = "recube-launcher-handler.desktop";
      "image/png" = "zen.desktop";
    };

    associations.added = {
      "application/pdf" = [
        "zen.desktop"
        "dms-open.desktop"
      ];
      "application/x-pdf" = [ "zen.desktop" ];
      "application/x-bzpdf" = [
        "zen.desktop"
        "dms-open.desktop"
      ];
      "application/x-gzpdf" = [
        "zen.desktop"
        "dms-open.desktop"
      ];
      "application/x-ext-pdf" = [
        "zen.desktop"
        "dms-open.desktop"
      ];
      "text/html" = [ "zen.desktop" ];
      "x-scheme-handler/http" = [ "zen.desktop" ];
      "x-scheme-handler/https" = [ "zen.desktop" ];
      "x-scheme-handler/chrome" = [ "zen.desktop" ];
    };
  };
}
