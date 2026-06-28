#!/usr/bin/env bash

detect_browser() {
    xdg-settings get default-web-browser | sed 's/\.desktop$//'
}
