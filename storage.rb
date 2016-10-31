
module Color
  WHITE = 1
  BLUE = 2
  GRAY = 3
end

class Storage

  def initialize(loading_strategy = nil)
    @root = Node.new("")
    unless loading_strategy.nil?
      @keys_loading_strategy = loading_strategy
      load_keys
    end
  end

  def add(key)
    add_key(key, @root)
  end

  def contains?(key)
    node = find_node(key.chars, @root)
    node != nil and node.is_finishing_node?
  end

  def find(key_prefix)
    key_prefix_array = key_prefix.chars
    raise ArgumentError.new('Key prefix must be longer than 2 symbols') if key_prefix.length < 3
    starting_search_node = find_node(key_prefix_array.dup, @root)
    key_prefix_array.pop
    key_prefix = key_prefix_array.join
    find_all_keys(starting_search_node).map { |key| key.prepend(key_prefix) }
  end

  def save_keys
    @keys_loading_strategy.save_keys(find_all_keys(@root))
  end

  private
  def find_all_keys(node)
    return [node.key] if node.is_blue?
    result_array = []
    node.each do |child|
      child_array = find_all_keys(child).map {|child_key| child_key.prepend(node.key)}
      result_array.push(*child_array)
    end
    result_array.push(node.key) if node.is_gray?
    result_array
  end

  private
  def load_keys
    keys = @keys_loading_strategy.load_keys
    keys.each {|key| add(key)}
  end

  private
  def find_node(key, current_node)
    return current_node if key.empty?
    next_node = current_node.get_child_with_key(key.shift)
    next_node.nil? ? nil : find_node(key, next_node)
  end

  private
  def add_key(key, current_node, current_index = 0)
    if key.length == current_index
      current_node.color = Color::BLUE if current_node.is_white?
      current_node.color = Color::GRAY if current_node.is_blue?
      return
    end
    next_node = get_or_create_next_node(key[current_index], current_node)
    current_node.add_child(next_node) if next_node.parent.nil?
    next_node.color = Color::GRAY if next_node.is_blue?
    add_key(key, next_node, current_index + 1)
  end

  private
  def get_or_create_next_node(key_item, current_node)
    next_node = current_node.get_child_with_key key_item
    if  next_node.nil?
      next_node = Node.new(key_item)
    end
    next_node
  end

  class Node
    attr_accessor :parent, :color, :key

    def initialize(key, color = Color::WHITE)
      @key = key
      @color = color
      @children = []
      @parent = nil
    end

    def add_child(child)
      @children.push(child)
      child.parent = self
      child
    end

    def is_white?
      @color == Color::WHITE
    end

    def is_blue?
      @color == Color::BLUE
    end

    def is_gray?
      @color == Color::GRAY
    end

    def is_finishing_node?
      is_blue? or is_gray?
    end

    def get_child_with_key(searched_key)
      @children.detect {|child| child.match_with_key searched_key}
    end

    def match_with_key(key)
      @key.eql? key
    end

    def each(&block)
      @children.each &block
    end
  end
end