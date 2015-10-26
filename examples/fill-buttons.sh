# Just like the fill.sh example, but includes filling buttons.

# Start with json from stdin, convert to fdf and fill the pdf with pdftk.

# Generate the fdf and save it to a file:
cat json/SF-52-button-fields.json | pdfq json_to_fdf > fdfs/SF-52-button-fields.fdf

# Apply the fdf to the pdf with pdftk:
pdftk pdfs/SF-52.pdf fill_form fdfs/SF-52-button-fields.fdf output pdfs/SF-52-filled-buttons.pdf
