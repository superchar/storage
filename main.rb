require './storage'
require './loaders/key_loader'

storage = Storage.new ArrayKeyLoader.new(['Hello,world!', 'Bye,World!', 'Hello,World42'])
puts storage.find('Hello')

