require 'zip'
require_relative  './file_key_loading_strategy'

class ZipFileKeyLoadingStrategy < FileKeyLoadingStrategy

  def initialize(zip_file_name, file_name)
    @zip_file_name = zip_file_name
    super(file_name)
  end

  protected
  def load_file_content
    open_zip_file.read(@file_name)
  end

  protected
  def save_file_content(content)
    open_zip_file.get_output_stream(@file_name)  do |file|
      file.write content
    end
  end

  private
  def open_zip_file
    Zip::File.open(@zip_file_name)
  end

end