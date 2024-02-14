#!/bin/bash

echo "Welcome to URLCheck, in this tool you can clean url list like remove 404, update redirection"
echo
echo "Enter input File Location"
read input_file
echo Input File Location is $input_file
echo
echo "Enter output File Location"
read output_file
echo Output File Location $output_file
echo 


#input_file="/home/d3m0n4u/Desktop/Bugbounty/NSF/collaborate/nsf.gov.txt"
#output_file="/home/d3m0n4u/Desktop/Bugbounty/NSF/collaborate/nsf.gov.txt_checked"

# Color codes
green='\033[0;32m'
red='\033[0;31m'
reset='\033[0m' # No Color

echo -e "Checking URLs for ${green}validity${reset}..."

# Start time measurement
start_time=$(date +%s.%N)

# Loop through each URL in the input file
while IFS= read -r url; do
    # Check HTTP connection and get the final URL after redirection
    redirected_url=$(curl -s -o /dev/null -w '%{url_effective}' -I -L -X HEAD -L "$url")

    # Get the status code of the request
    status_code=$(curl -s -o /dev/null -w '%{http_code}' -I -L -X HEAD -L "$url")

    if [ "$status_code" -eq 404 ]; then
        echo -e "${red}$url${reset} returned 404. Removing from the list."
    elif [ "$redirected_url" != "$url" ]; then
        echo -e "${green}$url${reset} redirected to ${green}$redirected_url${reset}. Adding redirected URL to output file."
        echo "$redirected_url" >> "$output_file"
    else
        echo -e "${green}$url${reset} is ${green}valid${reset}. Adding to output file."
        echo "$url" >> "$output_file"
    fi
done < "$input_file"

# End time measurement
end_time=$(date +%s.%N)
elapsed_time=$(echo "$end_time - $start_time" | bc)

echo -e "${green}Finished${reset} checking URLs. Redirected and valid URLs saved to $output_file."
echo -e "Time taken: ${elapsed_time} seconds."
