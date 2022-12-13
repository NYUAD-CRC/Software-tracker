#! /bin/bash

# Checking user input
if [ $# -eq 0 ];then
        echo "No arguments supplied, please input application name"
        exit 0
else
        echo "Searching for $# applications in all nodes"
fi
printf "\n"

divider4=============
divider3==================================
divider2====================================================================
divider=$divider2$divider2$divider2


for var in "$@"
do
	echo $divider3
	# Checking in all running nodes the application $1 with CPU usafge more than 50 and print the node name
	echo "Application $var is running on :"
	echo $divider3

	printf "\n"
	echo "Dalma nodes:"
	echo $divider4
	cat All_Dalma_Results | grep $var | cut -d : -f 1 | sort -u | sed -z 's/\n/,/g;s/,$/\n/'

	printf "\n"
	echo "Jubail nodes:"
	echo $divider4
	cat All_Jubail_Results | grep $var | cut -d : -f 1 | sort -u | sed -z 's/\n/,/g;s/,$/\n/'

	printf "\n"
	printf "\n"
done
