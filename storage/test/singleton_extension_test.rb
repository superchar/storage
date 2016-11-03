require_relative './test_helper'
require 'storage/core/storage'
require 'storage/extensions/singleton'

class SingletonExtensionTest < MiniTest::Test

  def test_singleton
    storage_instances =  (0..10).map {Storage.instance}
    current_instance = Storage.instance
    storage_instances.each {|storage_instance| assert storage_instance.equal? current_instance }
  end
end