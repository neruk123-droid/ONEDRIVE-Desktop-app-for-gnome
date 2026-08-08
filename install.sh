#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_NAME="onedrive-rclone"
APP_TITLE="OneDrive Rclone GNOME"

DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

INSTALL_DIR="$DATA_HOME/$APP_NAME"
BIN_DIR="$BIN_HOME"
DESKTOP_DIR="$DATA_HOME/applications"

mkdir -p "$INSTALL_DIR" "$BIN_DIR" "$DESKTOP_DIR"

install -Dm755 "$PROJECT_ROOT/bin/montar_onedrive.sh" "$BIN_DIR/montar_onedrive.sh"
install -Dm755 "$PROJECT_ROOT/src/onedrive_indicator.py" "$INSTALL_DIR/onedrive_indicator.py"
install -Dm755 "$PROJECT_ROOT/uninstall.sh" "$INSTALL_DIR/uninstall.sh"
install -Dm644 "$PROJECT_ROOT/assets/onedrive.png" "$INSTALL_DIR/onedrive.png"
install -Dm644 "$PROJECT_ROOT/assets/onedrive1.png" "$INSTALL_DIR/onedrive1.png"

cat > "$DESKTOP_DIR/montar_onedrive.desktop" <<EOF
[Desktop Entry]
Name=$APP_TITLE
Comment=Montar OneDrive con rclone y mostrar indicador en GNOME
Exec=$BIN_DIR/montar_onedrive.sh
Icon=$INSTALL_DIR/onedrive.png
Terminal=false
Type=Application
Categories=Utility;
StartupNotify=false
EOF

chmod 755 "$BIN_DIR/montar_onedrive.sh"
chmod 755 "$INSTALL_DIR/onedrive_indicator.py"
chmod 755 "$INSTALL_DIR/uninstall.sh"

echo "Instalado en:"
echo "  $INSTALL_DIR"
echo "  $BIN_DIR/montar_onedrive.sh"
echo "  $INSTALL_DIR/uninstall.sh"
echo "  $DESKTOP_DIR/montar_onedrive.desktop"
