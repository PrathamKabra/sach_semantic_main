Automated Web Scraping to Google Drive 🚀
This repository contains a simple yet powerful Bash script that automates the process of scraping large datasets from a website and streaming them directly to Google Drive. This method is ideal for situations where the dataset exceeds your local machine's storage capacity.

The Problem
When dealing with large-scale web scraping, the traditional workflow of downloading files to a local machine and then manually uploading them to cloud storage is inefficient and prone to failure. This is especially true when the scraped data is larger than the available disk space on the local machine.

The Solution
This solution leverages rclone, a powerful command-line program for managing cloud storage. The included Bash script uses rclone to stream data directly from a source URL to a Google Drive folder without ever saving the files locally. This completely bypasses the local storage bottleneck.

The script is a drop-in replacement for traditional wget or curl-based downloads. It includes a rate-limiting feature to prevent API errors from services like Google Drive.

Prerequisites
To use this script, you must have rclone installed and configured on your machine.

Install rclone: Open your terminal and run the official installation script.

curl [https://rclone.org/install.sh](https://rclone.org/install.sh) | sudo bash

Configure a Google Drive Remote: This is a one-time setup that securely links your machine to your Google Drive.

rclone config

Follow the prompts to create a new remote. Name it googledrive.

Choose Google Drive from the list of cloud storage options.

Accept the default values for Client ID, Client Secret, and Service Account File by pressing Enter.

When prompted to "Use auto config?", type n and follow the instructions to authenticate via a web browser.

Choose n for a Team Drive.

Confirm your settings.

The Script
Save the following code into a file named scraper.sh using a code editor like VS Code.

#!/bin/bash

# Base URL and directory structure
BASE_URL="[https://static.case.law](https://static.case.law)"
APP_DIR="$1"  # Pass the app directory (e.g., f3d) as a variable
START_NUM="$2"  # Pass the start number (e.g., 1) as a variable
MAX_NUM="$3"  # Pass the maximum number (e.g., 5) as a variable

# The destination folder on your Google Drive.
# Your remote name is "googledrive".
GDRIVE_DESTINATION="googledrive:Master_Data/USA/CAP/United States/Federal Reporter 3d Series (1990-2019)/$APP_DIR"

echo "Streaming files directly to Google Drive..."

# Download and upload PDF files (START_NUM.pdf to MAX_NUM.pdf)
for i in $(seq "$START_NUM" "$MAX_NUM")
do
    SOURCE_PDF_URL="${BASE_URL}/${APP_DIR}/${i}.pdf"
    DEST_PDF_PATH="${GDRIVE_DESTINATION}/${i}.pdf"
    
    echo "Processing $SOURCE_PDF_URL..."
    rclone copyurl "$SOURCE_PDF_URL" "$DEST_PDF_PATH" --progress --tpslimit 0.5
done

# Download and upload JSON metadata from subdirectories
for i in $(seq "$START_NUM" "$MAX_NUM")
do
    SOURCE_JSON_URL="${BASE_URL}/${APP_DIR}/${i}/CasesMetadata.json"
    DEST_JSON_PATH="${GDRIVE_DESTINATION}/${i}.json"
    
    echo "Processing $SOURCE_JSON_URL..."
    rclone copyurl "$SOURCE_JSON_URL" "$DEST_JSON_PATH" --progress --tpslimit 0.5
done

echo "All files have been successfully streamed to Google Drive!"

How to Run the Script
Make the Script Executable: Open your terminal, navigate to the directory where you saved the file, and run the following command:

chmod +x scraper.sh

Execute the Script: Run the script by providing the required arguments: APP_DIR, START_NUM, and MAX_NUM.

For example, to download the first 100 cases from the f3d series:

./scraper.sh f3d 1 100

Key Features
No Local Storage: The script uses rclone copyurl to stream data, avoiding the need for temporary local storage.

Rate-Limiting: The --tpslimit 0.5 flag is included to prevent "RATE_LIMIT_EXCEEDED" errors from the Google Drive API.

Organized Output: Files are automatically organized into subdirectories on your Google Drive for easy access.