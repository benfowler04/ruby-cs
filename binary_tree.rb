class Node
    attr_accessor :value, :left, :right

    def initialize(value = nil, left = nil, right = nil)
        @value = value
        @left = left
        @right = right
    end
end

class Tree
    def initialize
        @root = Node.new
    end

    def build_tree(array)
        array.each do |value|
            if @root.value.nil?
                @root.value = value
            else
                append(value)
            end
        end
    end

    def breadth_first_search(value)
        nodes = [@root]
        until nodes.empty?
            current_node = nodes.shift
            if current_node.value == value
                return current_node
            else
                nodes.push(current_node.left) unless current_node.left.nil?
                nodes.push(current_node.right) unless current_node.right.nil?
            end
        end
        nil
    end

    def depth_first_search(value)
        nodes = [@root]
        until nodes.empty?
            current_node = nodes.pop
            if current_node.value == value
                return current_node
            else
                nodes.push(current_node.left) unless current_node.left.nil?
                nodes.push(current_node.right) unless current_node.right.nil?
            end
        end
        nil
    end

    def dfs_rec(value, current_node = @root)
        return current_node if current_node.value == value
        left = dfs_rec(value, current_node.left) unless current_node.left.nil?
        return left unless left.nil?
        right = dfs_rec(value, current_node.right) unless current_node.right.nil?
        return right unless right.nil?
        nil
    end

    private
    def append(value, current_node = @root)
        if value < current_node.value && current_node.left.nil?
            current_node.left = Node.new(value)
        elsif value < current_node.value
            append(value, current_node.left)
        elsif current_node.right.nil?
            current_node.right = Node.new(value)
        else
            append(value, current_node.right)
        end
    end
end