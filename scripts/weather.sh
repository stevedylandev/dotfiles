#!/usr/bin/env bash

set -euo pipefail

gridpoint=${WEATHER_GRIDPOINT:-MRX/23,5}
base_url="https://api.weather.gov/gridpoints/${gridpoint}/forecast"

cloudy=󰖐
fog=󰖑
hail=󰖒
hazy=󰼰
storm=󰖓
clear_night=󰖔
rain=󰖖
snow=󰖘
clear_day=󰖙

usage() {
	cat <<'USAGE'
usage: weather.sh [-h|--hourly] [-j|--json]

  -h, --hourly   use the hourly forecast instead of the daily one
  -j, --json     print { "text": ..., "tooltip": ... } (waybar friendly)

env:
  WEATHER_GRIDPOINT   NWS gridpoint, default MRX/23,5
USAGE
}

hourly=false
json=false
while (($#)); do
	case $1 in
	-h | --hourly) hourly=true ;;
	-j | --json) json=true ;;
	--help) usage && exit 0 ;;
	*) usage >&2 && exit 1 ;;
	esac
	shift
done

$hourly && weather_url="$base_url/hourly" || weather_url="$base_url"

data=$(curl -sSL --fail --max-time 10 -H 'Accept: application/geo+json' "$weather_url" |
	jq -r '.properties.periods[0] | [.icon, .temperature, .temperatureUnit, .shortForecast, .isDaytime] | @tsv') || {
	echo "weather: request failed" >&2
	exit 1
}

IFS=$'\t' read -r icon_url temp unit short is_day <<<"$data"

# https://api.weather.gov/icons/land/night/tsra_hi,20/bkn?size=small
#                             ^period      ^condition
icon_path=${icon_url%%\?*}      # drop the query string
icon_path=${icon_path#*/icons/} # land/night/tsra_hi,20/bkn
icon_path=${icon_path#*/}       # night/tsra_hi,20/bkn
period=${icon_path%%/*}         # day|night
condition=${icon_path#*/}
condition=${condition%%/*}      # first of the (up to two) conditions
condition=${condition%%,*}      # drop the ",20" precip chance

night=false
[[ $period == night || $is_day == false ]] && night=true

# NWS icon vocabulary -> glyph.
case $condition in
skc | few | hot | cold) $night && glyph=$clear_night || glyph=$clear_day ;;
sct | bkn | ovc | wind_skc | wind_few | wind_sct | wind_bkn | wind_ovc) glyph=$cloudy ;;
tsra | tsra_sct | tsra_hi | tornado | hurricane | tropical_storm) glyph=$storm ;;
rain | rain_showers | rain_showers_hi) glyph=$rain ;;
snow | blizzard | rain_snow | snow_sleet) glyph=$snow ;;
sleet | fzra | rain_fzra | snow_fzra | rain_sleet) glyph=$hail ;;
fog) glyph=$fog ;;
haze | smoke | dust) glyph=$hazy ;;
*) glyph="" ;;
esac

# Fall back to a keyword match on the forecast text, most specific first.
if [[ -z $glyph ]]; then
	case ${short,,} in
	*thunder* | *tstm* | *tornado* | *hurricane* | *tropical*) glyph=$storm ;;
	*hail* | *sleet* | *freezing* | *ice*) glyph=$hail ;;
	*snow* | *flurr* | *blizzard* | *wintry*) glyph=$snow ;;
	*rain* | *shower* | *drizzle*) glyph=$rain ;;
	*fog* | *mist*) glyph=$fog ;;
	*haze* | *hazy* | *smoke* | *dust*) glyph=$hazy ;;
	*cloud* | *overcast*) glyph=$cloudy ;;
	*clear* | *sunny* | *fair* | *hot*) $night && glyph=$clear_night || glyph=$clear_day ;;
	*) $night && glyph=$clear_night || glyph=$clear_day ;;
	esac
fi

if $json; then
	jq -cn --arg text "$glyph $temp°$unit" --arg tooltip "$short" \
		'{text: $text, tooltip: $tooltip}'
else
	printf '%s %s°%s\n' "$glyph" "$temp" "$unit"
fi
