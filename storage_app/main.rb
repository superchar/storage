require './storage'
require './loaders/zip_file_key_loading_strategy'

storage = Storage.new
keys_array = %w(vlad vlad vladislav vladislav vladislav42 vladislav42 vladik28)
keys_array.each {|key| storage.add key}
keys_array.each {|key| puts storage.contains? key}
puts storage.contains? 'vladislav4'

puts storage.find 'vlad'
puts storage.find 'vladislav'