require_relative './test_helper'
require 'storage/loaders/array_key_loading_strategy'

class TestArrayLoadingStrategy < MiniTest::Test

  def setup
    @target_array = %w(Hello-world! Vladislav, Hello,world!!)
    @loading_strategy = ArrayKeyLoadingStrategy.new(@target_array)
  end

  def test_load_keys
    assert_equal @target_array, @loading_strategy.load_keys
  end

  def test_save_keys
    new_keys_array = %w(these the last worlds)
    @loading_strategy.save_keys(new_keys_array)
    assert_equal @target_array, new_keys_array
  end

end