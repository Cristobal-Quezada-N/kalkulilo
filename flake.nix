{
  description = "Flutter Dev Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
        };
        androidComposition = pkgs.androidenv.composeAndroidPackages {
            buildToolsVersions = [ "34.0.0" ];
            platformVersions = [ "29" ];
        };
        androidSDK = androidComposition.androidsdk;
      in
      {
        devShells.default = with pkgs; mkShell {
            ANDROID_HOME = "${androidSDK}/libexec/android-sdk";
            ANDROID_SDK_ROOT = "${androidSDK}/libexec/android-sdk/platform-tools";
            CHROME_EXECUTABLE="${pkgs.chromium}/bin/chromium";
            buildInputs = [
                flutter
                androidSDK
                jdk17
                chromium
            ];
        };
      }
    );
}
