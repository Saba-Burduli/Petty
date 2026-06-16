#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-run}"
APP_NAME="Petty"
PROJECT_PATH="Petty/Petty.xcodeproj"
SCHEME="Petty"
CONFIGURATION="Debug"
BUNDLE_ID="com.petty.desktop"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DERIVED_DATA_DIR="$ROOT_DIR/build/DerivedData"
APP_BUNDLE="$DERIVED_DATA_DIR/Build/Products/$CONFIGURATION/$APP_NAME.app"
APP_BINARY="$APP_BUNDLE/Contents/MacOS/$APP_NAME"

stop_app() {
  pkill -x "$APP_NAME" >/dev/null 2>&1 || true
  pkill -f "/$APP_NAME.app/Contents/MacOS/$APP_NAME" >/dev/null 2>&1 || true
}

build_app() {
  xcodebuild \
    -project "$ROOT_DIR/$PROJECT_PATH" \
    -scheme "$SCHEME" \
    -configuration "$CONFIGURATION" \
    -derivedDataPath "$DERIVED_DATA_DIR" \
    build
}

open_app() {
  /usr/bin/open -n "$APP_BUNDLE"
}

verify_running() {
  sleep 2
  if ! pgrep -x "$APP_NAME" >/dev/null; then
    echo "$APP_NAME launched but is not running." >&2
    exit 1
  fi
  echo "$APP_NAME is running."
}

usage() {
  echo "usage: $0 [run|--debug|--logs|--telemetry|--verify]" >&2
}

stop_app
build_app

case "$MODE" in
  run)
    open_app
    verify_running
    ;;
  --debug|debug)
    lldb -- "$APP_BINARY"
    ;;
  --logs|logs)
    open_app
    verify_running
    /usr/bin/log stream --info --style compact --predicate "process == \"$APP_NAME\""
    ;;
  --telemetry|telemetry)
    open_app
    verify_running
    /usr/bin/log stream --info --style compact --predicate "subsystem == \"$BUNDLE_ID\""
    ;;
  --verify|verify)
    open_app
    verify_running
    ;;
  *)
    usage
    exit 2
    ;;
esac
