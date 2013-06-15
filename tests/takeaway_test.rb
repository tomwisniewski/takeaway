require 'test/unit'
require 'mocha/setup'
require '../lib/takeaway'

class TestTakeaway < MiniTest::Unit::TestCase

  def setup
    @takeaway = Takeaway.new
    @order = {
      fish_and_chips: 2,
      shephards_pie: 1,
      bangers_and_mash: 5
    }
  end 

  def test_cost_of_single_item_can_be_calculated
    order1 = { fish_and_chips: 1 }
    @takeaway.stubs(:send_text)
    @takeaway.order(order1, 7)
    assert_equal 7, @takeaway.total
  end  

  def test_cost_of_multiple_items_can_be_calculated
    @takeaway.stubs(:send_text)
    @takeaway.order(@order, 57)
    assert_equal 57, @takeaway.total
  end     

  def test_error_is_raised_if_payment_is_not_exact
    assert_raises(RuntimeError) do
      assert_equal 57, @takeaway.order(@order, 56)
    end
  end

  def test_text_is_sent_upon_successful_order
    @takeaway.stubs(:send_text).returns("Order placed")
    assert_equal "Order placed", @takeaway.order(@order, 57)
  end

end 