// import external libraries
const fs = require('fs');
const readline = require('readline');
const crypto = require("crypto");

// Get the arguments and assign them to its proper variables
var myArgs = process.argv.slice(2);

const hashString = myArgs[0];
const wordlist = myArgs[1];

// Calculate hash length to try to guess the hash algorithm
const hashLength = hashString.length;

if (hashLength == 32) {
	var hashType = "MD5";
}
else if (hashLength == 40) {
	var hashType = "SHA1";
}
else if (hashLength == 64) {
	var hashType = "SHA256";
}
else if (hashLength == 128) {
	var hashType = "SHA512";
}

// Create hash functions
function md5(data) {
	return crypto.createHash("md5").update(data, "binary").digest("hex");
}

function sha1(data) {
	return crypto.createHash("sha1").update(data, "binary").digest("hex");
}

function sha256(data) {
    return crypto.createHash("sha256").update(data, "binary").digest("hex");
}

function sha512(data) {
	return crypto.createHash("sha512").update(data, "binary").digest("hex");
}

// Main banner, just to create a pretty layout
console.log("\n-----------------------------------------------------------------------")
console.log("hashCracker by MEGANUKE")
console.log("-----------------------------------------------------------------------")

console.log("\n-----------------------------------------------------------------------")
console.log("[-] Hash: %s", hashString)
console.log("[-] Hash Algorithm: %s", hashType)
console.log("[-] Wordlist: %s", wordlist)
console.log("-----------------------------------------------------------------------\n")


console.time('script execution');

// Read file
const readInterface = readline.createInterface({
	input: fs.createReadStream(wordlist),
	// output: process.stdout,
	console: false,
});

// For every line calculate hash and compare it to the provided string
if (hashType == "MD5") {
	console.log("Bruteforcing MD5 Hash...");
	readInterface.on('line', function(line) {
		var hashedPassword = md5(line);
		if (hashedPassword == hashString) {
			console.log("The password is \"%s\"", line);
			console.timeEnd('script execution');
		}
	});	
}

else if (hashType == "SHA1") {
	console.log("Bruteforcing SHA1 Hash...");
	readInterface.on('line', function(line) {
		var hashedPassword = sha1(line);
		if (hashedPassword == hashString) {
			console.log("The password is \"%s\"", line);
			console.timeEnd('script execution');
		}
	});
}

else if (hashType == "SHA256") {
	console.log("Bruteforcing SHA256 Hash...");
	readInterface.on('line', function(line) {
		var hashedPassword = sha256(line);
		if (hashedPassword == hashString) {
			console.log("The password is \"%s\"", line);
			console.timeEnd('script execution');
		}
	});
}

else if (hashType == "SHA512") {
	console.log("Bruteforcing SHA512 Hash...");
	readInterface.on('line', function(line) {
		var hashedPassword = sha512(line);
		if (hashedPassword == hashString) {
			console.log("The password is \"%s\"", line);
			console.timeEnd('script execution');
		}
	});
}