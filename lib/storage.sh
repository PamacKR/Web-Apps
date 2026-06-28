#!/usr/bin/env bash

DATA_DIR="$HOME/.local/share/install-web-apps"

create_storage() {

    mkdir -p "$DATA_DIR/icons"
    mkdir -p "$DATA_DIR/metadata"

    printf "✓ Created storage\n"

}

save_metadata() {

    local name="$1"
    local url="$2"
    local browser="$3"

    jq -n \
        --arg name "$name" \
        --arg url "$url" \
        --arg browser "$browser" \
        '{
            name: $name,
            url: $url,
            browser: $browser
        }' \
        > "$DATA_DIR/metadata/${SLUG}.json"

    printf "✓ Saved metadata\n"

}
