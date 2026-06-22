#!/usr/bin/env bash
# Catalog moved to dotdeps/.config/dotdeps/catalog.sh (stow package).
# This file sources the new location for backward compatibility.
_new="${ROOT_DIR:-}/dotdeps/.config/dotdeps/catalog.sh"
if [[ -f "$_new" ]]; then
    source "$_new"
elif [[ -f "$HOME/.config/dotdeps/catalog.sh" ]]; then
    source "$HOME/.config/dotdeps/catalog.sh"
fi
