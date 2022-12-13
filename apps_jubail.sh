#! /bin/bash

# Cleaning old results
rm Jubail_Results.csv
rm All_Jubail_Results

# Defining all Jubail nodes that has running jobs
sinfo -h -N | grep cn | grep 'alloc\|mix'| awk '{print $1}'| sort -u > Jubail_nodes.txt

# Replacing new line by , in nodes names' file
nodes=$(sed -z 's/\n/,/g;s/,$/\n/' Jubail_nodes.txt)

# Going int each of nodes that has running jobs and Checking runing commands that has CPU usage more than 50%
clush -w ${nodes} ps -axo user,%cpu,command | awk '{ if ($3>50 && $3<100) {print $1 $4} else if ($3>=100) { for (counter=0 ; counter < $3/100 ; counter ++) print $1 $4}  }'>> All_Jubail_Results

# Removal of aboslute path and change it to only application name
#awk -F "/" '{print $NF }' All_Jubail_Results >> Cleaned_All_Jubail_Results
cat All_Jubail_Results | cut -d : -f 2 | awk -F "/" '{print $NF }' >>Cleaned_All_Jubail_Results


# Removal of [] from application name
sed -i 's/\[//g; s/\]//g' Cleaned_All_Jubail_Results

# Appending , at the end of each line (comparison purpose)
sed -i 's/$/,/' Cleaned_All_Jubail_Results


# Counting the total number of processes per Apllication
for i in $(cat Cleaned_All_Jubail_Results  | sort -u)
do
	count=$(grep -c $i Cleaned_All_Jubail_Results)
	echo $i $count >> Counting_Jubail_Results
done

# Putting the header of the output file
echo "Application,Processes" >Jubail_Results.csv

# Sorting  Applications and its associated processes in descending order
sort  -n -k 2 -r Counting_Jubail_Results >>Jubail_Results.csv

# Removing intermediate files
rm Cleaned_All_Jubail_Results
rm Counting_Jubail_Results
rm Jubail_nodes.txt

