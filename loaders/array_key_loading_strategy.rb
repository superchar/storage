require '../loaders/key_loading_strategy'

class ArrayKeyLoadingStrategy < KeyLoadingStrategy

  def initialize(target_array)
    @target_array = target_array
  end

  def load_keys
    @target_array
  end

  def save_keys(keys)
    @target_array = keys
  end
end