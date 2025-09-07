# Sourcing Accurate Cases without Hallucinations 
# (SACH/सच)

## Data pipeline from raw source to trained vector databases

- Number 1 -> Extracting PDFs from the source
- Number 2 -> Migrating Metadata from all the JSONs to a common metadata .csv file
- Number 3 -> Batching PDF Files based on the equality distribution logic by moving in a temp folder and then deleting temp
- Number 4 -> Updating batch column in newly updated fields
- Number 5 -> Once everything is set till step 4, the batch_chunking.py file shall start from the smallest last unchunked batch to the largest.
- Number 6 -> Train the vector database
