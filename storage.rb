
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

  private
  def add_key(key, current_node, current_index = 0)
    if key.length == current_index
      current_node.color = current_node.is_leaf? ? Color::BLUE : Color::GRAY
      return
    end
    next_node = get_or_create_next_node(key[current_index], current_node)
    current_node.add_child(next_node)
    next_node.color = Color::GRAY if next_node.color == Color::BLUE
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

    def get_child_with_key(searched_key)
      @children.detect {|child| child.match_with_key searched_key}
    end

    def match_with_key(key)
      @key.eql? key
    end
  end
end