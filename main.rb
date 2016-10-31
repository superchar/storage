require './storage'
require './loaders/zip_file_key_loading_strategy'

storage = Storage.new(ZipFileKeyLoadingStrategy.new('./test_files/keys.zip', 'keys.txt'))
storage.add('vladislav1!')
storage.save_keys