
module Color
  WHITE = 1
  BLUE = 2
  GRAY = 3
end

class Storage

  def initialize
    @root = Node.new("")
  end

  def add(key)
    add_key(key, @root)
  end

  def contains?(key)
    node = find_node(key.chars, @root)
    node != nil and node.is_finishing_node?
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
      return
    end
    next_node = get_or_create_next_node(key[current_index], current_node)
    current_node.add_child(next_node)
    next_node.color = Color::GRAY if next_node.is_blue?
    add_key(key, next_node, current_index + 1)
  end

  private
  def get_or_create_next_node(key_item, current_node)
    next_node = current_node.get_child_with_key key_item
    if current_node.is_leaf? or next_node.nil?
      next_node = Node.new(key_item)
    end
    next_node
  end

  class Node
    attr_accessor :parent, :color

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

    def is_leaf?
      @children.length == 0
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
  end
end