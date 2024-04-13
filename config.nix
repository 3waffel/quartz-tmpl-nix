{
  defaultConfig = {
    pageTitle = "Quartz Template Nix";
    baseUrl = "example.com";
    enableSPA = true;
    enablePopovers = true;
    analytics = {
      provider = "plausible";
    };
    locale = "en-US";
    ignorePatterns = ["private" "templates" ".obsidian"];
    defaultDateType = "created";
    theme = {
      fontOrigin = "googleFonts";
      cdnCaching = true;
      typography = {
        header = "Schibsted Grotesk";
        body = "Source Sans Pro";
        code = "IBM Plex Mono";
      };
      colors = {
        lightMode = {
          light = "#faf8f8";
          lightgray = "#e5e5e5";
          gray = "#b8b8b8";
          darkgray = "#4e4e4e";
          dark = "#2b2b2b";
          secondary = "#284b63";
          tertiary = "#84a59d";
          highlight = "rgba(143, 159, 169, 0.15)";
        };
        darkMode = {
          light = "#161618";
          lightgray = "#393639";
          gray = "#646464";
          darkgray = "#d4d4d4";
          dark = "#ebebec";
          secondary = "#7b97aa";
          tertiary = "#84a59d";
          highlight = "rgba(143, 159, 169, 0.15)";
        };
      };
    };
  };
}
