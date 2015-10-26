# This is a convenience method for filtering for just the button fields.
# It does not require jq.

pdftk pdfs/SF-52.pdf dump_data_fields | pdfq buttons
