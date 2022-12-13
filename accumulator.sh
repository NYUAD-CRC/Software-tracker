#! /bin/bash

# Removal of old results
rm Apps.csv
rm dalma_apps_final
rm jubail_apps_final

#Reading apps' names from dalma and Jubail results without the header which is at line 1
cat Dalma_Results.csv | cut -d " " -f 1 |tail -n+2 >Application.csv
cat Jubail_Results.csv | cut -d " " -f 1 |tail -n+2 >>Application.csv

#Removal of dupliants
sort -u Application.csv > Apps.csv

file=$(cat Apps.csv)
i=0

#Calculating number of running processes for dalma and jubail for each Application and write them with the same order in dalma and Jubail files
#For example first line will be for python application for both dalma and jubail files and second line for gmx_mpi and so on
while read -r line; do

	#If the Application is found in Dalma
	if grep "$line" Dalma_Results.csv
	then
		#Read the number of procesees from the file and put it in count variable
		count=$(grep $line Dalma_Results.csv | cut -d "," -f 2)
	else
		#Means this application is not running on Dalma
		count="0"
	fi
	#Write the count in the file
	echo "$count" >>Applications_dalma
	
	#If the Application is found in Jubail
	if grep "$line" Jubail_Results.csv
	then
		#Read the number of procesees from the file and put it in count variable
		count=$(grep $line Jubail_Results.csv | cut -d "," -f 2)
	else
		#Means this application is not running on Jubail
		count="0"
	fi
	#Write the count in the file
	echo "$count" >>Applications_jubail
	#Incrementing the iterator
	i=$((i+1))

#Doing these steps for all line in file "Apps.csv" which includes the application names	
done <Apps.csv

# Removal of spaces in files
cat Applications_dalma | tr -d " \t\r" >dalma_apps_final
cat Applications_jubail | tr -d " \t\r" >jubail_apps_final 
cat Apps.csv | tr -d "," >Final_apps

# Removal of intermediate file
rm Applications_dalma
rm Applications_jubail
rm Application.csv
