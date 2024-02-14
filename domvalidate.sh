#!/bin/bash

echo "Welcome, here you can validate domains if they exist"
echo
echo "Enter File Location"
read input_file
echo File name is $input_file
echo
echo "Enter Output File Location"
read output_file
echo Output File name is $output_file
echo
#input_file="/home/d3m0n4u/Desktop/Bugbounty/NSF/collaborate/research.gov.txt"
#output_file="/home/d3m0n4u/Desktop/Bugbounty/NSF/collaborate/research.gov.txt_checked"

# Color codes
green='\033[0;32m'
red='\033[0;31m'
reset='\033[0m' # No Color

echo -e "Checking subdomains from ${green}$input_file${reset}..."

# Loop through each subdomain in the input file
while IFS= read -r subdomain; do
    echo -n -e "Checking ${green}$subdomain${reset}... "
    # Perform DNS lookup for the subdomain
    if nslookup "$subdomain" >/dev/null 2>&1; then
        # If DNS lookup succeeds, save the subdomain to the output file
        echo "$subdomain" >> "$output_file"
        echo -e "${green}exists.${reset} Saved to ${green}$output_file${reset}"
    else
        echo -e "${red}does not exist.${reset}"
    fi
done < "$input_file"

echo -e "${green}Finished${reset} checking subdomains. Existing subdomains saved to ${green}$output_file${reset}."
