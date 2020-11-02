#!/bin/sh

STATUS=$(nordvpn status | grep Status | tr -d ' ' | cut -d ':' -f2)

if [ "$STATUS" = "Connected" ]; then
    my_country=$(nordvpn status | grep Country | tr -d ' ' | cut -d ':' -f2)
    my_ip=$(nordvpn status | grep IP | tr -d ' ' | cut -d ':' -f2)
    echo "  $my_country"
else
    echo ""
fi
