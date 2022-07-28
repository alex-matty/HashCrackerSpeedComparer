<?php

// Get arguments from the user and assign them to its corresponding variables

$hashingVariables = getopt("s:w:");

$hashString = $hashingVariables['s'];
$userWordlist = $hashingVariables['w'];

// Count character of the string to try to guess the hash algorithm
$hashLenght = strlen($hashString);

// Depending of the string lenght choose the apropiate algorithm
if ($hashLenght == 32) {
	$hashType = "MD5";
}
elseif ($hashLenght == 40) {
	$hashType = "SHA1";
}
elseif ($hashLenght == 64) {
	$hashType = "SHA256";
}
elseif ($hashLenght == 128) {
	$hashType = "SHA512";
}

// Main banner, just to create a pretty layout
echo "\n-----------------------------------------------------------------------\n";
echo "hashCracker by MEGANUKE\n";
echo "-----------------------------------------------------------------------\n";

echo "\n-----------------------------------------------------------------------\n";
echo "[-] Hash: $hashString\n";
echo "[-] Hash Algorithm: $hashType\n";
echo "[-] Wordlist: $userWordlist\n";
echo "-----------------------------------------------------------------------\n";

// Open the file to use as a wordlist
$wordlist = fopen($userWordlist, "r") or die ("Unable to open file!");

// Calculate script runtime
$startTime = microtime(true);

// Compare the hash with every single entry of the wordlist
if ($hashType == "MD5") {
	echo "Bruteforcing MD5 Hash\n";
	while(! feof($wordlist)) {
		$fileLine = rtrim(fgets($wordlist));
		$hashedPassword = hash('md5', $fileLine);
		if ($hashedPassword == $hashString) {
			echo "The Password is \"$fileLine\"\n";
			break;
		}
	}
}

elseif ($hashType == "SHA1") {
	echo "Bruteforcing SHA1 Hash\n";
	while(! feof($wordlist)) {
		$fileLine = rtrim(fgets($wordlist));
		$hashedPassword = hash('sha1', $fileLine);
		if ($hashedPassword == $hashString) {
			echo "The Password is \"$fileLine\"\n";
			break;
		}
	}	
}

elseif ($hashType == "SHA256") {
	echo "Bruteforcing SHA256 Hash\n";
	while(! feof($wordlist)) {
		$fileLine = rtrim(fgets($wordlist));
		$hashedPassword = hash('sha256', $fileLine);
		if ($hashedPassword == $hashString) {
			echo "The Password is \"$fileLine\"\n";
			break;
		}
	}	
}

elseif ($hashType == "SHA512") {
	echo "Bruteforcing SHA512 Hash\n";
	while(! feof($wordlist)) {
		$fileLine = rtrim(fgets($wordlist));
		$hashedPassword = hash('sha512', $fileLine);
		if ($hashedPassword == $hashString) {
			echo "The Password is \"$fileLine\"\n";
			break;
		}
	}	
}

$endTime = microtime(true);
$totalTime = ($endTime - $startTime);

echo "Script runtime = $totalTime seconds\n";

?>