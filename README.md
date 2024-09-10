```shell
#!/bin/bash

#---------------------------------------------- Header
echo -e "$blue
   _____       __                          __ __
 ______    _____  __   ___  ____    
(   __ \  / ___/ () ) / __)/ __ \   
 ) (__) )( (__   ( (_/ /  / /  \ \  
(    __/  ) __)  ()   (  ( ()  () ) 
 ) \ \  _( (     () /\ \ ( ()  () ) 
( ( \ \_))\ \___ ( (  \ \ \ \__/ /  
 )_) \__/  \____\()_)  \_\ \____/ -r4hu1.exe"

echo " "

# Initialize variables
domain=""
inputdirectory=""

#---------------------------------------------- Help and Options
for arg in "$@"
do
    case $arg in
        -h|--help)
        echo -e "$lightblue




# Recon Script

## Overview

The Recon Script is a shell script designed to perform domain reconnaissance and enumeration using popular tools like `subfinder`, `httpx`, `assetfinder`, and `amass`. This script helps in gathering subdomains, verifying HTTP responses, and identifying additional assets related to a target domain.

## Tools Used

- **[subfinder](https://github.com/projectdiscovery/subfinder)**: A fast subdomain discovery tool that finds subdomains using various sources.
- **[httpx](https://github.com/projectdiscovery/httpx)**: A fast and multi-purpose HTTP toolkit that can be used to probe for live hosts and HTTP services.
- **[assetfinder](https://github.com/tomnomnom/assetfinder)**: A tool to find subdomains for a given domain.
- **[amass](https://github.com/OWASP/Amass)**: A powerful tool for network mapping and attack surface discovery.

## Features

- **Subdomain Enumeration**: Uses `subfinder` and `assetfinder` to gather subdomains.
- **HTTP Response Verification**: Uses `httpx` to check which subdomains are live and responding.
- **Comprehensive Discovery**: Uses `amass` for additional subdomain enumeration and asset discovery.

## Prerequisites

Before running the script, ensure that you have the following tools installed:

- [subfinder](https://github.com/projectdiscovery/subfinder)
- [httpx](https://github.com/projectdiscovery/httpx)
- [assetfinder](https://github.com/tomnomnom/assetfinder)
- [amass](https://github.com/OWASP/Amass)

You can install these tools using the following commands:

```bash
# Install subfinder
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Install httpx
go install github.com/projectdiscovery/httpx/cmd/httpx@latest

# Install assetfinder
go install github.com/tomnomnom/assetfinder@latest

# Install amass
go install github.com/OWASP/Amass/v3/...@latest
