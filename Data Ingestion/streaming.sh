#!/bin/bash

# Base URL and directory structure
BASE_URL="https://static.case.law"
APP_DIR="$1"  # Pass the app directory (e.g., f3d) as a variable
START_NUM="$2"  # Pass the start number (e.g., 1) as a variable
MAX_NUM="$3"  # Pass the maximum number (e.g., 5) as a variable

# The destination folder on your Google Drive.
# Your remote name is "googledrive".
GDRIVE_DESTINATION="googledrive:Master_Data/USA/CAP/United States/Federal Reporter 3d Series (1990-2019)"

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