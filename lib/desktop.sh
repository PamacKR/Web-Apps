#!/usr/bin/env bash

create_desktop_file() {

    mkdir -p "$HOME/.local/share/applications"

    local icon="$HOME/.local/share/install-web-apps/icons/${SLUG}.png"

    cat > "$HOME/.local/share/applications/${SLUG}.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$NAME
Exec=/usr/bin/$BROWSER --app=$URL
Icon=$icon
Terminal=false
Categories=Network;
StartupNotify=true
EOF

    update-desktop-database "$HOME/.local/share/applications" >/dev/null 2>&1 || true

    printf "✓ Created desktop launcher\n"

}
