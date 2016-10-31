require 'minitest/autorun'

require_relative '../loaders/array_key_loading_strategy'

class TestArrayLoadingStrategy < MiniTest::Test
  def setup
    @target_array = ['Hello-world!','Vladislav', 'Hello,world!!']
    @loading_strategy = ArrayKeyLoadingStrategy.new(@target_array)
  end

  def test_load_keys
    assert_equal @target_array, @loading_strategy.load_keys
  end
end