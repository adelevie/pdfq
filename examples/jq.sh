# jq allows you to query json that gets piped into it.
# In this example, jq filters for fields where FieldType is a Button.

pdftk pdfs/SF-52.pdf dump_data_fields | pdfq | jq '.[] | select(.FieldType=="Button")'
