# The simplest example:
# Take the output from dump_data_fields, pipe it into pdfq, and output json.

pdftk pdfs/SF-52.pdf dump_data_fields | pdfq
