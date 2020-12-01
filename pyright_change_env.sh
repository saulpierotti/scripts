#!/bin/bash
# Hack to change the conda environment of the LSP pyright

COC_CONF="$HOME/.config/nvim/coc-settings.json"
# $PATH is set by vim-conda at runtime as the env name
NEW_PATH=$(echo "$PATH" | cut -d: -f1)/python

# do not use / as a delimiter otherwise it fails with the / in the path
sed -i "s@\"python.pythonPath\":.*@\"python.pythonPath\": \"$NEW_PATH\",@" "$COC_CONF"
