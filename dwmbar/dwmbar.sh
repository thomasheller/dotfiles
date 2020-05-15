#!/bin/bash

# volume

volume=$(amixer sget Master | awk -F'[][]' '/Mono:/{ print $2 }' | tr -d %)

case $volume in
	100)
		;&
	[7-9]*)
		bar="${bar} 🔊"
		;;
	[4-6]*)
		bar="${bar} 🔉"
		;;
	[0-3]*)
		bar="${bar} 🔈"
		;;
esac

bar="${bar} $volume%"

# wifi

bar="${bar} 📶 "$(iwgetid -r)

# battery

capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

case $status in
	Full)
		bar="${bar} ✅"
		;;
	Discharging)
		bar="${bar} 🔋"
		;;
	Charging)
		bar="${bar} 🔌"
		;;
esac

bar="${bar} $capacity%"

# cpu

cpu=$(grep 'cpu ' /proc/stat | awk '{printf "%.f", ($2+$4)*100/($2+$4+$5)}')
temp=$(cat /sys/devices/virtual/thermal/thermal_zone0/temp | awk '{ print $1/1000 }')

if [[ $temp -gt 60 ]]
then
	tempwarn=" ⚠"
fi

bar="${bar} cpu: $cpu% (temp: ${temp}°C$tempwarn)"

# memory

mem=$(free | awk '/Mem:/{printf "%.f", $3/$2 * 100.0}')
bar="${bar} mem: $mem%"

# timestamp

bar="${bar} 📅 "$(date '+%F %R')

# done!

xsetroot -name "$bar"

