require_relative './test_helper'
require 'storage/core/storage'

class StorageTest < MiniTest::Test
  def setup
    @storage = Storage.new
  end

  def test_add
    keys_to_add = %w(first second third fourth)
    add_keys(keys_to_add)
    contains_results = keys_to_add.map { |key| @storage.contains? key}
    contains_results.each {|result| assert result}
  end

  def test_contains
    existing_key = 'existing key'
    @storage.add(existing_key)
    assert @storage.contains? existing_key
    refute @storage.contains? 'not existing key'
  end

  def test_find
    keys_to_add = %w(Hello Hello,world! Hello,world42! Vladislav Prefix something some thing someword)
    add_keys(keys_to_add)
    hello_prefix = 'Hello'
    some_prefix = 'some'
    hello_prefix_keys = find_by_prefix(keys_to_add, hello_prefix)
    array_equals(hello_prefix_keys, @storage.find(hello_prefix))
    some_prefix_keys = find_by_prefix(keys_to_add, some_prefix)
    array_equals(some_prefix_keys, @storage.find(some_prefix))
  end

  private
  def array_equals(first_array, second_array)
    assert_equal first_array.sort, second_array.sort
  end

  private
  def find_by_prefix(array, prefix)
    array.select { |key| key.start_with? prefix }
  end

  private
  def add_keys(keys)
    keys.each {|key| @storage.add(key)}
  end

end