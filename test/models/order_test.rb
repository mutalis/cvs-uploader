require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = Order.new(category: 'category one', state: 'active')
    @order.patients << Patient.new(patient_name: 'p1',state: 'active')
    @deleted_order = Order.new(category: 'category one', state: 'deleted')
  end

  test 'patients association' do
    assert_equal 1, @order.patients.size
  end

  test 'scope active' do
    refute_includes Order.active, @deleted_order
  end
end
