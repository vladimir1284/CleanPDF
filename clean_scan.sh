#!/bin/bash
# Set the input PDF filenames from arguments
pdf_files=("$@")
# Array to store the generated PNG files
png_files=()
# Convert PDF files to PNG images with verbosity
for pdf_file in "${pdf_files[@]}"
do
    # Set the output image filenames
    img_filename="${pdf_file%.*}_img"

    echo "Converting $pdf_file to PNG images..."
    pdftoppm -png "$pdf_file" "${img_filename[@]}"

    # Get the generated PNG files for each PDF
    generated_files=("${img_filename}"*.png)
    png_files+=("${generated_files[@]}")
    echo "Conversion of $pdf_file completed. Generated ${#generated_files[@]} PNG images."
done

echo "Generated the following images:"
echo "${png_files[@]}"

# Use all the generated PNG files in the noteshrink command
echo "Executing noteshrink command with ${#png_files[@]} PNG images..."
/home/vladimir/Downloads/noteshrink/noteshrink.py -K "${png_files[@]}"
echo "noteshrink command completed."
echo "Performing cleanup..."
rm -f "${png_files[@]}"
rm -f page*.png
echo "Cleanup completed."