
require_relative  './key_loading_strategy'

class FileKeyLoadingStrategy < KeyLoadingStrategy

  attr_reader :file_name

  protected :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def load_keys
    load_file_content.split(';')
  end

  def save_keys(keys)
    save_file_content(keys.join(';'))
  end

  protected
  def load_file_content
    IO.read(@file_name)
  end

  protected
  def save_file_content(content)
    IO.write(@file_name, content)
  end
end