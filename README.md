# Antivirus Daemon and Restore Tool

## 1. Overview and Folder Hierarchy
This project implements an antivirus daemon and an interactive restore menu. The daemon continuously monitors a specified directory for malicious files, automatically moving them to a quarantine folder.

**Folder Hierarch:**
* `antivirusd.sh`: The background monitoring script.
* `restore.sh`: The interactive terminal menu for managing quarantined files.
* `Makefile`: setting shortcuts for executing the scripts.
* `dir/`: The target directory being actively monitored by the antivirus.
* `malicious_dir/`: The quarantine directory where flagged files are isolated.

## 2. Prerequisites and Installation
* **Operating System:** Ubuntu Linux
* **Required Packages:** `make`
* **Installation Instructions:** To install `make` on Ubuntu, open your terminal and run the following commands:
  ```bash
  sudo apt update
  sudo apt install make
  ```
## 3. Step-by-Step Running Instructions
You can run the tools using the following Makefile shortcuts from:

**Step 1: Start the Antivirus Daemon**
Run the following command in your terminal:
```bash
make run-antivirus
```
*This automatically creates the `malicious_dir` if it is missing and starts monitoring the `dir` folder every 3 seconds.*

**Step 2: Launch the Restore Menu**
Run the following command in your terminal:
```bash
make run-restore
```
*This opens an interactive menu allowing you to restore files back to `dir`, permanently delete them, or leave them in quarantine.*

## 4. Location of Flagged-Extensions and Flagged-Keywords
The required flagged-extensions and flagged-keywords lists are defined inside the code of the `antivirusd.sh` script. 

* **Flagged-Extensions:** Defined as an array inside `antivirusd.sh` (checking for `.exe`, `.bat`, `.ps1`, `.vbs`, `.scr`).
* **Flagged-Keywords:** Defined as an array near the very top of `antivirusd.sh` (checking for `malware`, `virus`, `trojan`, `worm`, `ransomware`).



