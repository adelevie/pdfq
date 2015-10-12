class TestPdfq < MTest::Unit::TestCase

  def test_main
    # assert_nil __main__([])
    assert true
  end

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
end

MTest::Unit.new.run
