require 'drb'

class Client

  def connect
    @storage = DRbObject.new_with_uri('druby://localhost:9999')
    self
  end

  def test
    words_to_add = %w(second section secret vladislav)
    puts "Adding words #{words_to_add}"
    words_to_add.each { |word| @storage.add(word) }
    (words_to_add + ["First word outside", "Second word outside"]).each { |word| puts "Contains word - #{word} -> #{@storage.contains? word}" }
    key_prefix = "sec"
    puts "Trying to find words with prefix - #{key_prefix}"
    puts "Words with prefix #{key_prefix} are #{@storage.find(key_prefix)}"
  end

end

Client.new.connect.test