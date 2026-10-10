#!/bin/bash
dir=$1
malicious_dir=$2
interval=$3
scan_directory(){
	for file in "$dir"/*; do
		if [ -f "$file" ]; then
			filename=$(basename "$file")
			is_whitelisted=0
                	while read -r line; do
                   		 if [[ "$filename" == "$line" ]]; then
                       			 is_whitelisted=1
                       			 break
                    		fi
                	done < "/home/os/9432-lab2/whitelist.txt"

                	if [ $is_whitelisted -eq 1 ]; then
                    		continue
                	fi
            		is_malicious=0
			if [[ "$file" == *.exe || "$file" == *.bat || "$file" == *.vbs || "$file" == *.scr || "$file" == *.ps1 ]]; then
				is_malicious=1
			fi
			shopt -s nocasematch
			while read -r line; do
				if [[ "$line" == *"virus"* || "$line" == *"trojan"* || "$line" == *"malware"* || "$line" == *"worm"* || "$line" == *"ransomware"* ]]; then
					is_malicious=1
					break
				fi
			done < "$file"
			shopt -u nocasematch
			if [ $is_malicious -eq 1 ]; then
				echo "$filename is malicious and it is DELETED"
				cp "$file" "$malicious_dir/"
				rm "$file"
			fi
		fi
	done
}
while true; do
	if [ ! -f directory-info.last ]; then
		scan_directory
		ls -l "$dir" > directory-info.last
	else
		ls -l "$dir" > directory-info.new
		if ! cmp -s directory-info.last directory-info.new; then
			scan_directory
			cp directory-info.new directory-info.last
		fi
	fi
	sleep "$interval"
done
