require_relative './test_helper'
require 'storage/loaders/file_key_loading_strategy'
require 'storage/loaders/zip_file_key_loading_strategy'

class ZippyOpenStubResult

  def initialize(read_content: nil, write_callback: nil)
    @read_content = read_content
    @write_callback = write_callback
  end

  def []=(file_name, file_content)
    @write_callback.call(file_name, file_content)
  end

  def [](file_name)
    @read_content
  end
end

class FileLoadingStrategyTest < MiniTest::Test

  def setup
    @target_array = %w(Hello-world! Vladislav Hello,world!!)
    @keys_file_stub_content = 'Hello-world!;Vladislav;Hello,world!!'
    @file_name = 'test.txt'
    @zip_file_name = 'test.zip'
    @write_callback = -> (file_name, file_content) do
      assert_equal @file_name, file_name
      assert_equal @keys_file_stub_content, file_content
    end
  end

  def test_load_keys_file
    IO.stub(:read, @keys_file_stub_content) do
      keys = FileKeyLoadingStrategy.new(@file_name).load_keys
      assert_equal @target_array, keys
    end
  end

  def test_save_keys_file
    IO.stub(:write, @write_callback) do
      FileKeyLoadingStrategy.new(@file_name).save_keys(@target_array)
    end
  end

  def test_load_keys_zip_file
    Zippy.stub(:open, ZippyOpenStubResult.new(read_content: @keys_file_stub_content)) do
      keys =  ZipFileKeyLoadingStrategy.new(@zip_file_name, @file_name).load_keys
      assert_equal @target_array, keys
    end
  end

  def test_save_keys_zip_file
    Zippy.stub(:open, ZippyOpenStubResult.new(write_callback: @write_callback)) do
      ZipFileKeyLoadingStrategy.new(@zip_file_name, @file_name).save_keys(@target_array)
    end
  end

end