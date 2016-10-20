
module Color
  WHITE = 1
  BLUE = 2
  GRAY = 3
end

class Storage

  attr_accessor :root

  def initialize
    @root = Node.new("")
  end

  def add(key)
    add_key(key, @root)
  end

  def print_children
    @root.print_children
  end

  private
  def add_key(key, current_node, current_index = 0)
    key_part = key[current_index]
    child_with_key_part = current_node.get_child_with_key key_part
    if current_node.is_leaf? or child_with_key_part.nil?
      new_child = Node.new(key_part)
      current_node.add_child(new_child)
      add_key(key, new_child, current_index + 1)
    end
    add_key(key, child_with_key_part, current_index + 1)
  end

  class Node
    attr_accessor :parent, :key, :children

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

    def print_children
      current_children = @children.dup
      while current_children.length ==!  0
        child = current_children.shift
        puts child.key
        current_children.push(child.children)
      end
    end

    def is_leaf?
      @children.length === 0
    end

    def contains_child_with_key(searched_key)
      @children.any? {|child| child.match_with_key searched_key}
    end

    def get_child_with_key(searched_key)
      @children.detect {|child| child.match_with_key searched_key}
    end

    def match_with_key(key)
      @key.eql? key
    end
  end
end