#!/usr/bin/env bash

install_icon() {

    local destination="$HOME/.local/share/install-web-apps/icons/${SLUG}.png"

    #
    # Extract domain
    #

    local domain

    domain=$(echo "$URL" \
        | sed 's#https\?://##' \
        | cut -d/ -f1)

    #
    # Download favicon
    #

    if curl -L \
        "https://www.google.com/s2/favicons?domain=${domain}&sz=256" \
        -o "$destination" \
        --silent \
        --fail
    then

        printf "✓ Downloaded icon\n"

    else

        cp assets/placeholder.png "$destination"

        printf "✓ Using placeholder icon\n"

    fi

}
