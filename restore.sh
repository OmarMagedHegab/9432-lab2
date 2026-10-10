#!/bin/bash
dir=$1
malicious_dir=$2
while true; do
	is_empty=1
	for file in "$malicious_dir"/*; do
		if [ -f "$file" ]; then
			is_empty=0
		fi
	done
	if [ $is_empty -eq 1 ]; then
		echo "No malicious files to review."
		exit 0
	fi
	echo "Files currently in quarantine:"
	select filepath in "$malicious_dir"/*; do
		if [ -f "$filepath" ]; then
			filename=$(basename "$filepath")
			echo "You selected: $filename"
            		echo "1: Restore this file back into $dir"
            		echo "2: Permanently delete this file from $malicious_dir"
            		echo "3: Leave this file as-is and go back to the list"
			read -p "Enter your choice from 1 to 3: " choice
			if [ "$choice" -eq 1 ]; then
				mv "$filepath" "$dir/"
				echo "$filename" >> /home/os/9432-lab2/whitelist.txt
				echo "Restored $filename to $dir."
				break
			elif [ "$choice" -eq 2 ]; then
				rm "$filepath"
				echo "$filename permanently deleted."
				break
			elif [ "$choice" -eq 3 ]; then
				break
			else
				echo "Invalid choice choose from 1 to 3"
			fi
		else
			echo "Invalid file selection, try again!"
		fi
	done
done

