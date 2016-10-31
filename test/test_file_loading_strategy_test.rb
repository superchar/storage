require_relative './test_helper'
require_relative '../loaders/file_key_loading_strategy'

class TestFileLoadingStrategyTest < MiniTest::Test
  def setup
    @target_array = %w(Hello-world! Vladislav Hello,world!!)
    @keys_file_stub_value = 'Hello-world!;Vladislav;Hello,world!!'
    @file_name = 'test.txt'
    @loading_strategy = FileKeyLoadingStrategy.new(@file_name)
  end

  def test_load_keys
    IO.stub(:read, @keys_file_stub_value) do
      assert_equal @target_array, @loading_strategy.load_keys
    end
  end

  def test_save_keys
    write_stub_method = MiniTest::Mock.new
    write_stub_method.expect(:write, nil, [@file_name, @keys_file_stub_value])
    IO.stub(:write, -> (file_name, content) { write_stub_method.write(file_name, content) }) do
      @loading_strategy.save_keys(@target_array)
    end
    write_stub_method.verify
  end
end