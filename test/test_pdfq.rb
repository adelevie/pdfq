class TestPdfq < MTest::Unit::TestCase
  def test_main
    assert_nil __main__([])
  end
end

MTest::Unit.new.run
