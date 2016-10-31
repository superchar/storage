class KeyLoader
  def load_keys
  end
end

class ArrayKeyLoader < KeyLoader
  def initialize(target_array)
    @target_array = target_array
  end

  def load_keys
    @target_array
  end
end