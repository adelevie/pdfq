require 'open3'
require 'json'

BIN_PATH = File.join(File.dirname(__FILE__), "../mruby/bin/pdfq")

assert('version') do
  output, status = Open3.capture2(BIN_PATH, "version")

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, "v0.0.1"
end

assert('json') do
  pdftk_string = %q(
---
FieldType: Text
FieldName: form1[0].#subform[0].item20[0]
FieldNameAlt: 20. ITEM DESCRIPTION
FieldFlags: 8388608
FieldJustification: Left
---
FieldType: Text
FieldName: form1[0].#subform[0].item21[0]
FieldNameAlt: 21. ITEM DESCRIPTION
FieldFlags: 8388608
FieldJustification: Left
---
FieldType: Text
FieldName: form1[0].#subform[0].SUBCONTRACTNUMBER[0]
FieldNameAlt: 9. SUBCONTRACT NUMBER
FieldFlags: 8388608
FieldJustification: Left
---
)
  output, status = Open3.capture2(BIN_PATH, stdin_data: pdftk_string)

  result = JSON.parse(output)

  assert_equal result.length, 4
  assert_equal result.first['FieldType'], 'Text'
  assert_equal result.first['FieldName'], 'form1[0].#subform[0].item20[0]'
  assert_equal result.first['FieldNameAlt'], '20. ITEM DESCRIPTION'
  assert_equal result.first['FieldFlags'], '8388608'
  assert_equal result.first['FieldJustification'], 'Left'
end
