# Import required modules
import hashlib
import argparse
import datetime

# Create the parser to get arguments
parser = argparse.ArgumentParser(description='Script to bruteforce hash cracking by comparing hash to a calculated hash of elements of a wordlist. Currently it supports MD5, SHA1, SHA256, SHA512')
parser.add_argument('-s', '--hash_string', help='Hash to crack')
parser.add_argument('-w', '--wordlist', help='Wordlist to use')

args = parser.parse_args()

# Map the arguments to its variable names
hash_string = args.hash_string
wordlist = args.wordlist

# Calculate size of the hash to try to guess Hash algorithm used
hash_length = len(hash_string)

if hash_length == 32:
	hash_type = 'MD5'
elif hash_length == 40:
	hash_type = 'SHA1'
elif hash_length == 64:
	hash_type = 'SHA256'
elif hash_length == 128:
	hash_type = 'SHA512'

# Define Hash functions to use them later in the script

def md5(string_to_hash):
	md5_hash = hashlib.md5((string_to_hash).encode()).hexdigest()
	return md5_hash

def sha1(string_to_hash):
	sha1_hash = hashlib.sha1(string_to_hash.encode()).hexdigest()
	return sha1_hash

def sha256(string_to_hash):
	sha256_hash = hashlib.sha256(string_to_hash.encode()).hexdigest()
	return sha256_hash

def sha512(string_to_hash):
	sha512_hash = hashlib.sha512(string_to_hash.encode()).hexdigest()
	return sha512_hash

# Create a layout showing user input and actions that will be performed
print("\n-----------------------------------------------------------------------")
print("hashCracker by MEGANUKE")
print("-----------------------------------------------------------------------\n")
print("----------------------------------------------------------------")
print("[-] HASH: " + hash_string)
print("[-] HASH Algorithm: " + hash_type)
print("[-] Wordlist: " + wordlist)
print("----------------------------------------------------------------\n")

# Open the wordlist, check if the line starts with a hash and if not append it to a list.
start_time = datetime.datetime.now()

wordlist = open(wordlist, 'r', encoding='ascii', errors='backslashreplace')

if hash_type == 'MD5':
	print('Bruteforcing MD5 HASH!')
	for element in wordlist:
		hashed_password = md5(element.strip('\n'))

		if hashed_password == hash_string:
			print("the password is " + "\"" + element.strip('\n') + "\"")

elif hash_type == 'SHA1':
	print('Bruteforcing SHA1 HASH!')
	for element in wordlist:
		hashed_password = sha1(element.strip('\n'))

		if hashed_password == hash_string:
			print("the password is " + "\"" + element.strip('\n') + "\"")

elif hash_type == 'SHA256':
	print('Bruteforcing SHA256 HASH!')
	for element in wordlist:
		hashed_password = sha256(element.strip('\n'))

		if hashed_password == hash_string:
			print("the password is " + "\"" + element.strip('\n') + "\"")

elif hash_type == 'SHA512':
	print('Bruteforcing SHA512 HASH!')
	for element in wordlist:
		hashed_password = sha512(element.strip('\n'))
		
		if hashed_password == hash_string:
			print("the password is " + "\"" + element.strip('\n') + "\"")

end_time = datetime.datetime.now()
total_time = end_time - start_time

print("Script runtime = " + str(total_time) + " seconds")