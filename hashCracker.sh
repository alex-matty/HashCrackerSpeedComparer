#!/bin/bash

# Check if required commands are installed
if ! command -v md5sum 2&>/dev/null
then
	echo "md5sum is not installed or not in PATH. Make sure to install it."
	exit
elif ! command -v sha1sum 2&>/dev/null
then
	echo "sha1sum is not installed or not in PATH. Make sure to install it."
	exit
elif ! command -v sha256sum 2&>/dev/null
then
	echo "sha256sum is not installed or not in PATH. Make sure to install it."
	exit
elif ! command -v sha512sum 2&>/dev/null
then
	echo "sha256sum is not installed or not in PATH. Make sure to install it."
	exit
fi

# Help function to show usage and syntax
Help() {
	echo "Script to bruteforce hash cracking by comparing hash to a calculated hash of elements of a wordlist. Currently it supports MD5, SHA1, SHA256, SHA512"
	echo "-s Hash string to bruteforce"
	echo "-w Wordlist to compare to"
}

# Get arguments from the user or show help menu
while getopts s:w:h flag
do
	case "${flag}" in
		s) hashString=${OPTARG};;
		w) userWordlist=${OPTARG};;
		h) Help
			exit;;
	esac
done

# Calculate the size of the string to guess the Hash algorithm used
hashLenght=$(echo -n $hashString | wc -c)

if [[ $hashLenght == 32 ]]
then
	hashType="MD5"
elif [[ $hashLenght == 40 ]]
then
	hashType="SHA1"
elif [[ $hashLenght == 64 ]]
then
	hashType="SHA256"
elif [[ $hashLenght == 128 ]]
then
	hashType="SHA512"
fi

#Main banner, just to create a pretty layout
echo -e "\n-----------------------------------------------------------------------"
echo "hashCracker by MEGANUKE"
echo "-----------------------------------------------------------------------"

echo -e "\n-----------------------------------------------------------------------"
echo "[-] Hash: $hashString"
echo "[-] Hash Algorithm: $hashType"
echo "[-] Wordlist: $userWordlist"
echo -e "-----------------------------------------------------------------------\n"

startTime=$(date +%s)

if [[ $hashType == "MD5" ]]
then
	echo "Bruteforcing MD5 Hash..."
	while read -r line
	do
		hashedPassword=$(echo -n $line | md5sum | awk '{print$1}')

		if [[ $hashedPassword == $hashString ]]
		then
			echo "The password is $line"
		fi
	done < $userWordlist
elif [[ $hashType == "SHA1" ]]
then
	echo "Bruteforcing SHA1 Hash..."
	while read -r line
	do
		hashedPassword=$(echo -n $line | sha1sum | awk '{print$1}')

		if [[ $hashedPassword == $hashString ]]
		then
			echo "The password is $line"
		fi
	done < $userWordlist
elif [[ $hashType == "SHA256" ]]
then
	echo "Bruteforcing SHA256 Hash..."
	while read -r line
	do
		hashedPassword=$(echo -n $line | sha256sum | awk '{print$1}')

		if [[ $hashedPassword == $hashString ]]
		then
			echo "The password is $line"
		fi
	done < $userWordlist
elif [[ $hashType == "SHA512" ]]
then
	echo "Bruteforcing SHA512 Hash..."
	while read -r line
	do
		hashedPassword=$(echo -n $line | sha512sum | awk '{print$1}')

		if [[ $hashedPassword == $hashString ]]
		then
			echo "The password is $line"
		fi
	done < $userWordlist
fi

endTime=$(date +%s)
totalTime=$((endTime-startTime))
echo "Script runtime = $totalTime seconds"