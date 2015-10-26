require 'open3'
require 'json'

BIN_PATH = File.join(File.dirname(__FILE__), "../mruby/bin/pdfq")

assert('version') do
  output, status = Open3.capture2(BIN_PATH, "version")

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, "v0.0.2"
end

assert('basic') do
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

assert('buttons') do
  pdftk_string = %q(
---
FieldType: Text
FieldName: TopmostSubform[0].Page1[0].Table2[0].TextField[0]
FieldNameAlt: Enter name of whom certificate must be returned by.
FieldFlags: 8388608
FieldValue:
FieldJustification: Left
FieldMaxLength: 10
---
FieldType: Button
FieldName: TopmostSubform[0].Page1[0].Table2[0].PrintButton1[0]
FieldNameAlt: Press Button to Print Form
FieldFlags: 65536
FieldValue:
FieldJustification: Left
---
FieldType: Button
FieldName: TopmostSubform[0].Page1[0].Table2[0].Button1[0]
FieldNameAlt: Save Form
FieldFlags: 65536
FieldValue:
FieldJustification: Left
---
FieldType: Button
FieldName: TopmostSubform[0].Page1[0].Table2[0].ResetButton1[0]
FieldNameAlt: Press Button to Clear Form
FieldFlags: 65536
FieldValue:
FieldJustification: Left
---
  )
  output, status = Open3.capture2(BIN_PATH, "buttons", stdin_data: pdftk_string)

  result = JSON.parse(output)

  assert_equal result.length, 3
  assert_equal result.first['FieldName'], 'TopmostSubform[0].Page1[0].Table2[0].PrintButton1[0]'
end
