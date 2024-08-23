#!/bin/bash

# This script reads information of users and create user accounts 

CSV_FILE="employee.csv"

if [ "$UID" -ne 0 ]
then
	echo "This script must be run by the root user"
	exit 1
fi

if [ ! -f "$CSV_FILE" ]
then
	echo "File not found: $CSV_FILE"
	exit 1
fi

#IFS Internal Field Separator
while IFS=, read -r username fullname
do
	password=$(openssl rand -base64 12)

	# -m create home dir for this user
	# -c create comment: fullname
	useradd -m -c "$fullname" "$username"

	# chpasswd: update the password
	echo "$username:$password" | chpasswd

	#force the user to change his password  after the first login
	chage -d 0 "$username" 

	echo "User created: $username"
	echo "Full Name: $fullname"
	echo "Random Password: $password"
	echo "-------------------------------"

	#save information for later use
	echo $username,$password >> out.txt

done < $CSV_FILE

echo "User creation completed!. "
