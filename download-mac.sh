#!/bin/sh

VERSION="v2.4.0"
URL="https://github.com/commander-cli/commander/releases/download/$VERSION/commander-darwin-amd64"
curl -L "$URL" -o commander
chmod +x commander

