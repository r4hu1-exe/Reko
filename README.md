# Recon Script

## Overview

The Recon Script is a shell script designed to perform domain reconnaissance and enumeration using popular tools like `subfinder`, `httpx`, `assetfinder`, `amass`, `waybackurls`, and `cewl`. This script helps in gathering subdomains, verifying HTTP responses, identifying additional assets related to a target domain, and generating wordlists.

## Tools Used

- **[subfinder](https://github.com/projectdiscovery/subfinder)**: A fast subdomain discovery tool that finds subdomains using various sources.
- **[httpx](https://github.com/projectdiscovery/httpx)**: A fast and multi-purpose HTTP toolkit that can be used to probe for live hosts and HTTP services.
- **[assetfinder](https://github.com/tomnomnom/assetfinder)**: A tool to find subdomains for a given domain.
- **[amass](https://github.com/OWASP/Amass)**: A powerful tool for network mapping and attack surface discovery.
- **[waybackurls](https://github.com/tomnomnom/waybackurls)**: Fetches URLs from the Wayback Machine for a given domain.
- **[cewl](https://github.com/digininja/CeWL)**: A custom wordlist generator that spiders a given URL to create a wordlist of unique words.

## Features

- **Subdomain Enumeration**: Uses `subfinder` and `assetfinder` to gather subdomains.
- **HTTP Response Verification**: Uses `httpx` to check which subdomains are live and responding.
- **Comprehensive Discovery**: Uses `amass` for additional subdomain enumeration and asset discovery.
- **Historical URLs**: Uses `waybackurls` to fetch historical URLs from the Wayback Machine.
- **Wordlist Generation**: Uses `cewl` to generate a wordlist based on the domain and its subdomains.

## Prerequisites

Before running the script, ensure that you have the following tools installed:

- [subfinder](https://github.com/projectdiscovery/subfinder)
- [httpx](https://github.com/projectdiscovery/httpx)
- [assetfinder](https://github.com/tomnomnom/assetfinder)
- [amass](https://github.com/OWASP/Amass)
- [waybackurls](https://github.com/tomnomnom/waybackurls)
- [cewl](https://github.com/digininja/CeWL)

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

# Install waybackurls
go install github.com/tomnomnom/waybackurls@latest

# Install cewl
sudo apt-get install cewl
