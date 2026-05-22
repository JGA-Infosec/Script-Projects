#! /usr/bin/bash
figlet -f slant "==recon chain=="
echo "----------------------------------------------------------"
echo "                  Made by John Gabriel                  "
sleep 1
echo "Initializing..."
sleep 1
echo "Enter IP of the target:"
read ip
echo "confirmed ip = $ip"
sleep 1
echo "========================================================="
echo "checking if target host is up..."
if ping -c 4 -W 1 "$ip" &>/dev/null; then
	echo "Target is UP"
else
	echo "Target is DOWN"
	echo "exiting"
	exit
fi
sleep 0.5
G='\033[0;32m'
NC='\033[0m'
echo "========================================================="
echo "scanning target..."
echo "Pick an output type:"
echo -e "1. Raw Output"
echo -e "2. Grepable Format"
read -t 5 AN
if [ -z "$AN" ]; then
	echo "Timed out, using default option...1"
	ports=$(rustscan -a "$ip"  2>/dev/null)
elif [ "$AN" = "2" ]; then
	ports=$(rustscan -a "$ip" -g 2>/dev/null)
elif [ "$AN" = "1" ]; then
	ports=$(rustscan -a "$ip"  2>/dev/null)
else
	echo "invalid input, 1 or 2 only. Using default option... 1"
	ports=$(rustscan -a "$ip" 2>/dev/null)
fi	
if [ -z "$ports" ]; then
		echo "no ports found."
	else
		echo "scan complete!"
		echo -e "$ports"
fi
echo "========================================================="
echo "Performing UDP scan..."
udpx=$(udpx -t "$ip" 2>/dev/null)
if [ "$udpx" ]; then
	sleep 0.5
	echo "here are the results:"
	echo "$udpx"
else
	echo "No open UDP ports detected."
fi
echo "========================================================="
echo "Perform NMAP scan?"
echo "1. Yes (Default: -A)"
echo "2. No"
read -p "Select:" nmap
if [ -z "$nmap" ] || [ "$nmap" = "2" ]; then
	echo "Skipping NMAP scan."
elif [ "$nmap" = "1" ]; then
	echo "Enter extra NMAP flags you want to use. (press enter to use default -A)"
	read -p "Enter Nmap flags here:" custom_nmap
	echo "Scanning $ip with nmap..."
	nmap -A $custom_nmap "$ip"
else
	echo "Invalid input."
fi
echo "========================================================="
echo "do you want to perform subdomain enumeration?"
echo "1. Yes"
echo "2. No"
read subd
if [ -z "$subd" ] || [ "$subd" = "2" ]; then
	echo "skipping subdomain enumeration.."
elif [ "$subd" = "1" ]; then
	read -p "Enter domain:" url
	read -p "Enter custom subfinder commands here (leave empty if none):" subc
	subfinder $subc -d "$url" 2>/dev/null
else
	echo "invalid input."
fi
