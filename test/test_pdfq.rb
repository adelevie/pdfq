class TestPdfq < MTest::Unit::TestCase

  def test_parse_pdftk_string
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
    result = parse_pdftk_string(pdftk_string)

    assert_equal result.length, 4
    assert_equal result.first['FieldType'], 'Text'
    assert_equal result.first['FieldName'], 'form1[0].#subform[0].item20[0]'
    assert_equal result.first['FieldNameAlt'], '20. ITEM DESCRIPTION'
    assert_equal result.first['FieldFlags'], '8388608'
    assert_equal result.first['FieldJustification'], 'Left'
  end

  def test_buttons
    pdft_string = %q(
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

    result = get_buttons_from_pdftk_string(pdft_string)

    assert_equal result.length, 3
    assert_equal result.first['FieldName'], 'TopmostSubform[0].Page1[0].Table2[0].PrintButton1[0]'
  end

  def test_convert_hash_to_fdf
    hash = {"foo" => "bar"}
    fdf = convert_hash_to_fdf(hash)

    assert fdf.is_a?(String)
    assert fdf.include?("foo")
    assert fdf.include?("bar")

    sample_fdf = [
      "%FDF-1.2",
      "1 0 obj",
      "<<",
      "/FDF << /Fields [<< /V (bar)/T (foo) >>",
      "] >>",
      ">>",
      "endobj",
      "trailer",
      "<<",
      "/Root 1 0 R",
      ">>",
      "%%EOF"
    ]

    sample_fdf.each do |line|
      assert fdf.include?(line)
    end
  end
end

MTest::Unit.new.run
