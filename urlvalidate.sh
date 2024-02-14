#!/bin/bash

echo "Welcome to UrlValidater, in this tool you can vaildate existing urls http/https"
echo
echo "Enter URL list location"
read input_file
echo Input File is $input_file
echo
echo "Enter Output file location"
read output_file
echo Output File is $output_file
echo

#input_file="existing_subdomains.txt"
#output_file="valid_urls.txt"

# Color codes
green='\033[0;32m'
red='\033[0;31m'
reset='\033[0m' # No Color

echo -e "Checking subdomains for ${green}valid URLs${reset}..."

# Loop through each subdomain in the input file
while IFS= read -r subdomain; do
    # Check HTTP connection
    if curl --output /dev/null --silent --head --fail "http://$subdomain"; then
        echo -e "${green}http://$subdomain${reset}" >> "$output_file"
        echo -e "${green}http://$subdomain${reset} added as a ${green}valid URL${reset}."
    else
        # Check HTTPS connection
        if curl --output /dev/null --silent --head --fail "https://$subdomain"; then
            echo -e "${green}https://$subdomain${reset}" >> "$output_file"
            echo -e "${green}https://$subdomain${reset} added as a ${green}valid URL${reset}."
        else
            echo -e "${red}$subdomain${reset} does ${red}not exist${reset}."
        fi
    fi
done < "$input_file"

echo -e "${green}Finished${reset} checking subdomains. ${green}Valid URLs${reset} saved to $output_file."
