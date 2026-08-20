#!/usr/bin/env bash

LOCATION=$1

# data=$(curl -sSL https://api.weather.gov/points/$LOCATION)
# echo $data

curl -sSL https://api.weather.gov/points/$LOCATION | jq -r '.properties.forecast'
