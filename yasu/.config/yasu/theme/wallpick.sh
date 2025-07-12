#!/bin/bash
for f in "$HOME/Pictures/walls"/*; do
    [ -f "$f" ] && basename "$f"
done
