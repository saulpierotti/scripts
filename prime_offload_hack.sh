#!/bin/bash
# Run prime_offload when needed by optimus-prime
# This is usually needed after a screen unlock

if optimus-manager --print-mode > /dev/null; then
    echo Prime did Xorg post-startup hook correctly
else
    echo Error: Prime did not do Xorg post-startup hook
    echo Calling prime-offload...
    prime-offload
fi
