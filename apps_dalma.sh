#! /bin/bash

# Cleaning old results
rm Dalma_Results.csv
rm All_Dalma_Results

# Defining all Dalma nodes that has running jobs
sinfo -h -N | grep dn | grep 'alloc\|mix'| awk '{print $1}'| sort -u > Dalma_nodes.txt

# Replacing new line by , in nodes names' file
nodes=$(sed -z 's/\n/,/g;s/,$/\n/' Dalma_nodes.txt)

# Going int each of nodes that has running jobs and Checking runing commands that has CPU usage more than 50%
clush -w ${nodes} ps -axo user,%cpu,command | awk '{ if ($3>50 && $3<100) {print $1 $4} else if ($3>=100) { for (counter=0 ; counter < $3/100 ; counter ++) print $1 $4}  }'>> All_Dalma_Results


# Removal of aboslute path and change it to only application name
#awk -F "/" '{print $NF }' All_Dalma_Results >> Cleaned_All_Dalma_Results
cat All_Dalma_Results | cut -d : -f 2 | awk -F "/" '{print $NF }' >>Cleaned_All_Dalma_Results

# Removal of [] from application name
sed -i 's/\[//g; s/\]//g' Cleaned_All_Dalma_Results

# Appending , at the end of each line (comparison purpose)
sed -i 's/$/,/' Cleaned_All_Dalma_Results

# Counting the total number of processes per each application
for i in $(cat Cleaned_All_Dalma_Results  | sort -u)
do
	count=$(grep -c $i Cleaned_All_Dalma_Results)
	echo $i $count >> Counting_Dalma_Results
done

# Putting the header of the output file
echo "Application,Processes" >Dalma_Results.csv

# Sorting  Applications and its associated processes in descending order
sort  -n -k 2 -r Counting_Dalma_Results >>Dalma_Results.csv

# Removing intermediate files
rm Cleaned_All_Dalma_Results
rm Counting_Dalma_Results
rm Dalma_nodes.txt
