require File.dirname(__FILE__) + '/../test_helper'

class BillTitleTest < Test::Unit::TestCase
  def setup
    @first = BillTitle.find :first
  end

  def test_bill_title
    assert_nothing_raised {@first.bill}
  end
end
