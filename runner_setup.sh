#!/bin/bash

# ------------------------------------------------------------------
#                   ░▒▓  EDITABLE CONSTANTS  ▓▒░
# ------------------------------------------------------------------

# Runner registration details
REPO_URL="https://github.com/<OWNER>/<REPO>"
REGISTRATION_TOKEN="<REGISTRATION_TOKEN>"   
RUNNER_NAME="pico-flasher"
RUNNER_LABELS="self-hosted,flasher"

# GitHub Actions runner
RUNNER_ROOT="$HOME/gha-runner"
RUNNER_VER="2.323.0"
RUNNER_TARBALL="actions-runner-linux-arm-${RUNNER_VER}.tar.gz"
RUNNER_URL="https://github.com/actions/runner/releases/download/v${RUNNER_VER}/${RUNNER_TARBALL}"

# ------------------------------------------------------------------
#                   ░▒▓  GENERAL CONSTANTS  ▓▒░
# ------------------------------------------------------------------

# Package groups
GIT_DEPS="git"
SDK_DEPS="cmake gcc-arm-none-eabi gcc g++ libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib python3-pip"
OPENOCD_DEPS="gdb-multiarch automake autoconf build-essential texinfo libtool libftdi-dev libusb-1.0-0-dev"
VSCODE_DEPS="code"
UART_DEPS="minicom"

# All packages to install
DEPS="$GIT_DEPS $SDK_DEPS $OPENOCD_DEPS $VSCODE_DEPS $UART_DEPS"

# Build locations / repos
BUILD_ROOT="$HOME/builds"
PICO_SDK_REPO="https://github.com/raspberrypi/pico-sdk"
PICOTOOL_REPO="https://github.com/raspberrypi/picotool"
PICO_SDK_PATH="$BUILD_ROOT/pico-sdk"


# ------------------------------------------------------------------
#                 ░▒▓  SCRIPT EXECUTION  ▓▒░
# ------------------------------------------------------------------

# System update & prerequisite packages
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt install -y $DEPS

# ── Build Environment Setup ───────────────────────────────────────

# PicoSDK install
mkdir -p "$BUILD_ROOT"
cd "$BUILD_ROOT"
git clone "$PICO_SDK_REPO"
cd pico-sdk
git submodule update --init
export PICO_SDK_PATH="$PICO_SDK_PATH"

# Picotool install
mkdir -p "$BUILD_ROOT"
cd "$BUILD_ROOT"
git clone "$PICOTOOL_REPO"
cd picotool
sudo make install
sudo cp udev/99-picotool.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger

# ── GitHub Actions Runner Setup ───────────────────────────────────

mkdir -p "$RUNNER_ROOT" && cd "$RUNNER_ROOT"

curl -LO "$RUNNER_URL"
tar xzf "$RUNNER_TARBALL"

./config.sh \
  --url "$REPO_URL" \
  --token "$REGISTRATION_TOKEN" \
  --name  "$RUNNER_NAME" \
  --labels "$RUNNER_LABELS" \
  --unattended

sudo ./svc.sh install        # writes /etc/systemd/system/actions.runner.<repo>.${RUNNER_NAME}.service
sudo systemctl enable --now "actions.runner.<repo>.${RUNNER_NAME}.service"

systemctl status "actions.runner.<repo>.${RUNNER_NAME}.service"