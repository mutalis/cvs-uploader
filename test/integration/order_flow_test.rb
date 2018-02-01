require 'test_helper'

class OrderFlowTest < ActionDispatch::IntegrationTest
  test "can see the orders page" do
    get "/"
    assert_select "h1", "Import a file"
    assert_select "form"
    assert_select "form input", 3
    assert_select "table" do
      assert_select "tr" do
        assert_select "td"
      end
    end
  end
end
