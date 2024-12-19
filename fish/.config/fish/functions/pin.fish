#!/usr/bin/env

# Get the URL from the command-line argument
set url $argv[1]

# Download the file using wget
wget -O downloaded_file $url

# Upload the file using Pinata
pinata upload downloaded_file

# Get the "bafy" value from the upload command
set bafy (echo $last_status | grep -o 'bafy.*')

# Construct the IPFS URL
set ipfs_url "https://docs.mypinata.cloud/ipfs/"$bafy

# Copy the IPFS URL
echo $ipfs_url

# Delete the original downloaded file
rm downloaded_file
