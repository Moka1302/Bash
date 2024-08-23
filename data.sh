#!/bin/bash

read -p "Enter your username: " name
read -p "Enter your fullname: " fullname

INFO=$name,$fullname

read -p "Please confirm that you have entered the correct information. Is everything correct ? [y/n] " input

case $input in
	No|no|N|n)
		exit
		;;
	yes|Yes|y|Y)
		echo $INFO >> employee.csv
		;;
	*)
		exit
		;;
esac

echo "your data has been stored successfully"
