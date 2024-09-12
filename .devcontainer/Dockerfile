FROM debian:bookworm

# Environment Variables

ARG USER=root

ARG BUILD_TOOLS_VERSION=34.0.0
ARG PLATFORM_VERSION=29
ARG COMMAND_LINE_VERSION=latest

ARG BROWSER=chromium

ENV ANDROID_HOME /usr/local/android-sdk
ENV ANDROID_USER_HOME $ANDROID_HOME/profiles/$USER
ARG ANDROID_SDK_BUNDLE=commandlinetools-linux-11076708_latest.zip
ARG ANDROID_SDK_BUNDLE_URL=https://dl.google.com/android/repository/$ANDROID_SDK_BUNDLE

ARG FLUTTER_HOME=/usr/local/flutter
ARG FLUTTER_BUNDLE=flutter_linux_3.24.2-stable.tar.xz
ARG FLUTTER_BUNDLE_URL=https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/$FLUTTER_BUNDLE

# Dependencies

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y curl git unzip xz-utils zip libglu1-mesa
RUN apt-get install -y clang cmake ninja-build pkg-config libgtk-3-dev
RUN apt-get install -y openjdk-17-jre
RUN apt-get install -y $BROWSER

# Workspace

USER root
WORKDIR /tmp

# Android

RUN mkdir -p $ANDROID_HOME/cmdline-tools $ANDROID_USER_HOME

RUN curl -O $ANDROID_SDK_BUNDLE_URL
RUN unzip $ANDROID_SDK_BUNDLE && rm $ANDROID_SDK_BUNDLE

RUN mv cmdline-tools $ANDROID_HOME/cmdline-tools/latest-tmp

RUN chown -R $USER:$USER $ANDROID_HOME

USER $USER
WORKDIR $ANDROID_HOME/cmdline-tools/latest-tmp/bin

RUN yes | ./sdkmanager --licenses
RUN ./sdkmanager "build-tools;${BUILD_TOOLS_VERSION}" "platform-tools" "platforms;android-${PLATFORM_VERSION}" "sources;android-${PLATFORM_VERSION}"
RUN ./sdkmanager --install "cmdline-tools;${COMMAND_LINE_VERSION}"

USER root
RUN rm -rf $ANDROID_HOME/cmdline-tools/latest-tmp

# Flutter

WORKDIR /tmp

RUN curl -O $FLUTTER_BUNDLE_URL
RUN tar -xf $FLUTTER_BUNDLE && rm $FLUTTER_BUNDLE
RUN mv flutter $FLUTTER_HOME

RUN chown -R $USER:$USER $FLUTTER_HOME

USER $USER
WORKDIR $FLUTTER_HOME

RUN yes | ./bin/flutter doctor --android-licenses

# Setup

USER $USER
WORKDIR /home

ENV CHROME_EXECUTABLE /usr/bin/$BROWSER
ENV PATH $PATH:$ANDROID_HOME/platform-tools:$FLUTTER_HOME/bin

RUN adb start-server

EXPOSE 1234
