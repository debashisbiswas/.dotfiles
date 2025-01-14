#!/bin/sh

notify() {
  echo "$1" && notify-send "$1"
}

if [[ $(rfkill list wifi | grep "Soft blocked: yes") ]]; then
  rfkill unblock all && notify "Airplane mode disabled"
else
  rfkill block all && notify "Airplane mode enabled"
fi
