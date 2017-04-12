#!/bin/bash
interface=$1
status=$2

set -x
if [[ "${interface}" == cscotun* ]] ; then
    echo "VPN interface"
else
    exit 0
fi

# Search these processes for the session variable
# (they are run as the current user and have the DBUS session variable set)
compatiblePrograms=( nautilus kdeinit kded4 pulseaudio trackerd )

# Attempt to get a program pid
for index in ${compatiblePrograms[@]}; do
    PID=$(pidof -s ${index})
    if [[ "${PID}" != "" ]]; then
        break
    fi
done

if [[ "${PID}" == "" ]]; then
    echo "Could not detect active login session"
    return 1
fi

QUERY_ENVIRON="$(tr '\0' '\n' < /proc/${PID}/environ | grep "DBUS_SESSION_BUS_ADDRESS" | cut -d "=" -f 2-)"
if [[ "${QUERY_ENVIRON}" != "" ]]; then
    export DBUS_SESSION_BUS_ADDRESS="${QUERY_ENVIRON}"
    echo "Connected to session:"
    echo "DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS}"
else
    echo "Could not find dbus session ID in user environment."
    exit 1
fi

case $status in
    up)
        su -l pair -c "set -x ; export DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS} ; gsettings set org.gnome.system.proxy mode auto ; gsettings set org.gnome.system.proxy autoconfig-url http://proxy.hwimo.lab.emc.com/proxy.pac"
        ;;
    down)
        su -l pair -c "set -x ; export DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS} ; gsettings set org.gnome.system.proxy mode none"
        ;;
esac
