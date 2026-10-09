setup:
	if [ ! -d "malicious_dir" ]; then mkdir "malicious_dir"; fi
run-antivirus: setup
	./antivirusd.sh dir malicious_dir 3
run-restore: setup
	./restore.sh dir malicious_dir
