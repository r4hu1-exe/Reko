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
Subscan4 - This script uses the following 4 tools (Sublister, Amass, Assetfinder, Httpx) to enumerate the target subdomains."
        echo " "
        echo "$0 [options]"
        echo " "
        echo "Options:"
        echo "        -h, --help                         show brief help"
        echo "        -d, --domain <domain>              domain to scan. Example: domain.com"
        echo "        -o, --output <dir>                 directory to save the results. Example: /output"
        echo " "
        echo "Example:"
        echo "        $0 -d domain.com -o /domain-com"
        echo -e "$white";
        exit 0
        ;;
        -d|--domain)
        domain="$2"
        shift 2
        ;;
        -o|--output)
        inputdirectory="$2"
        shift 2
        ;;
        *)
        echo "Unknown option: $arg"
        echo "Use -h or --help for usage information."
        exit 1
        ;;
    esac
done

# Ensure output directory exists
mkdir -p "$outputDir$inputdirectory"

#---------------------------------------------- Main Logic
echo -e "$orange[Assetfinder] in progress..."
assetfinder -subs-only "$domain" | tee "$outputDir$inputdirectory/assetfinder-$domain.txt" > /dev/null 2>&1
echo -e "$orange[Httpx] in progress with the results Assetfinder..."
httpx -silent -no-color -l "$outputDir$inputdirectory/assetfinder-$domain.txt" -title -tech-detect -content-length -web-server -status-code -ports 80,81,82,88,135,143,300,443,554,591,593,832,902,981,993,1010,1024,1311,2077,2079,2082,2083,2086,2087,2095,2096,2222,2480,3000,3128,3306,3333,3389,4243,4443,4567,4711,4712,4993,5000,5001,5060,5104,5108,5357,5432,5800,5985,6379,6543,7000,7170,7396,7474,7547,8000,8001,8008,8014,8042,8069,8080,8081,8083,8085,8088,8089,8090,8091,8118,8123,8172,8181,8222,8243,8280,8281,8333,8443,8500,8834,8880,8888,8983,9000,9043,9060,9080,9090,9091,9100,9200,9443,9800,9981,9999,10000,10443,12345,12443,16080,18091,18092,20720,28017,49152 -threads 25 -o "$outputDir$inputdirectory/assetfinder-httpx-$domain.txt" > /dev/null 2>&1
cut -d' ' -f1 < "$outputDir$inputdirectory/assetfinder-httpx-$domain.txt" | sort -u > "$outputDir$inputdirectory/live-assetfinder-httpx-$domain.txt"
echo -e "$blue[OK Assetfinder] scan performed."
echo -e ""

echo -e "$orange[Amass] in progress..."
amass enum --passive -d "$domain" -o "$outputDir$inputdirectory/amass-$domain.txt" > /dev/null 2>&1
echo -e "$orange[Httpx] in progress with the results Amass..."
httpx -silent -no-color -l "$outputDir$inputdirectory/amass-$domain.txt" -title -tech-detect -content-length -web-server -status-code -ports 80,81,82,88,135,143,300,443,554,591,593,832,902,981,993,1010,1024,1311,2077,2079,2082,2083,2086,2087,2095,2096,2222,2480,3000,3128,3306,3333,3389,4243,4443,4567,4711,4712,4993,5000,5001,5060,5104,5108,5357,5432,5800,5985,6379,6543,7000,7170,7396,7474,7547,8000,8001,8008,8014,8042,8069,8080,8081,8083,8085,8088,8089,8090,8091,8118,8123,8172,8181,8222,8243,8280,8281,8333,8443,8500,8834,8880,8888,8983,9000,9043,9060,9080,9090,9091,9100,9200,9443,9800,9981,9999,10000,10443,12345,12443,16080,18091,18092,20720,28017,49152 -threads 25 -o "$outputDir$inputdirectory/amass-httpx-$domain.txt" > /dev/null 2>&1
cut -d' ' -f1 < "$outputDir$inputdirectory/amass-httpx-$domain.txt" | sort -u > "$outputDir$inputdirectory/live-amass-httpx-$domain.txt"
echo -e "$blue[OK Amass] scan performed."
echo -e ""

# Merge subdomains into one file, eliminating duplicates
echo -e "$blue[OK] Master file creation for subdomains."
sleep 1.5
cat "$outputDir$inputdirectory/live-*.txt" >> "$outputDir$inputdirectory/master_live_subdomains-$domain.txt"
sort "$outputDir$inputdirectory/master_live_subdomains-$domain.txt" | uniq > "$outputDir$inputdirectory/all_live_subdomains-$domain.txt"

# Use waybackurls on the filtered subdomains
echo -e "$orange[Waybackurls] in progress with the filtered subdomains..."
cat "$outputDir$inputdirectory/all_live_subdomains-$domain.txt" | waybackurls > "$outputDir$inputdirectory/waybackurls-$domain.txt"
echo -e "$blue[OK Waybackurls] scan performed."
echo -e ""

# Use cewl to generate a wordlist from the domain and subdomains
echo -e "$orange[Cewl] in progress to generate a wordlist..."
cewl -d 2 -m 5 -w "$outputDir$inputdirectory/cewl-wordlist-$domain.txt" -v "$domain"
for subdomain in $(cat "$outputDir$inputdirectory/all_live_subdomains-$domain.txt"); do
    cewl -d 2 -m 5 -w "$outputDir$inputdirectory/cewl-wordlist-$domain.txt" -a -v "$subdomain"
done
echo -e "$blue[OK Cewl] wordlist generation performed."
echo -e ""

echo -e ""
echo -e "$red\e[1m[OK] DONE!\e[0m $white"
echo -e ""
