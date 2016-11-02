
module Color
  WHITE = 1
  BLUE = 2
  GRAY = 3
end

class Storage
  def initialize(loading_strategy = nil)
    @root = Node.new('')
    unless loading_strategy.nil?
      @keys_loading_strategy = loading_strategy
      load_keys
    end
  end

  def add(key)
    add_key(key.chars, @root)
  end

  def contains?(key)
    node = find_node(key.chars, @root)
    not node.nil? and node.is_finishing_node?
  end

  def find(key_prefix)
    raise ArgumentError.new('Key prefix must be longer than 2 symbols') if key_prefix.length < 3
    key_last_node = find_node(key_prefix.chars, @root) # Searching is stared from last prefix symbol, to avoid unnecessary calls.
    return [] if key_last_node.nil?
    prefix_of_key_prefix = key_prefix[0, key_prefix.length - 1] # We take prefix from key prefix, because searching is started from last prefix symbol (for example 'vlad' from 'd') and hence it will be included in result as well
    find_all_keys(key_last_node).map { |key| prefix_of_key_prefix + key  }
  end

  def save_keys
    raise Exception.new('Keys loading strategy object was not provided') if @keys_loading_strategy.nil?
    @keys_loading_strategy.save_keys(find_all_keys(@root))
  end

  private
  def find_all_keys(node)
    return [node.key] if node.is_blue?
    keys = node.children.map { |child| find_all_keys(child) }.flatten.map { |child_key| node.key + child_key }
    keys.push(node.key) if node.is_gray?
    keys
  end

  private
  def load_keys
    keys = @keys_loading_strategy.load_keys
    keys.each {|key| add(key)}
  end

  private
  def find_node(key, current_node)
    return current_node if key.empty?
    next_node = current_node.get_child_by_key(key.shift)
    next_node.nil? ? nil : find_node(key, next_node)
  end

  private
  def add_key(key, current_node)
    if key.empty?
      update_last_searching_node(current_node)
    else
      next_node = get_or_create_next_node(key.shift, current_node)
      current_node.add_child(next_node) if next_node.parent.nil?
      next_node.color = Color::GRAY if next_node.is_blue?
      add_key(key, next_node)
    end
  end

  private
  def update_last_searching_node(last_node)
    if last_node.is_white?
      last_node.color = Color::BLUE
    elsif last_node.is_blue?
      last_node.color = Color::GRAY
    end
  end

  private
  def get_or_create_next_node(key_item, current_node)
    next_node = current_node.get_child_by_key(key_item)
    if next_node.nil?
      next_node = Node.new(key_item)
    end
    next_node
  end

  class Node
    attr_accessor :parent, :color, :key, :children

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

    def get_child_by_key(searched_key)
      @children.detect {|child| child.key == searched_key}
    end

    def each(&block)
      @children.each &block
    end
  end
end
