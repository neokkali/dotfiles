#!/bin/bash


dbus-monitor --system "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged'" | while read -r line; do
  # تحقق من تغير البطارية
  if echo "$line" | grep -q "Percentage"; then
    # اقرأ مستوى البطارية الحالي
    PERCENT=$(upower -i $(upower -e | grep battery) | grep percentage | awk '{print int($2)}')
    STATUS=$(upower -i $(upower -e | grep battery) | grep state | awk '{print $2}')

    if [[ "$PERCENT" -le 15 && "$STATUS" == "discharging" ]]; then
      notify-send -u critical "Battery $CHARGE% is low charg your device ⚠️" 
    fi
  fi
done
