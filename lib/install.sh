#!/usr/bin/env bash

run_install() {

    create_storage

    save_metadata "$NAME" "$URL" "$BROWSER"

    install_icon

    create_desktop_file

}
