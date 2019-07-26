class Node
    attr_accessor :value, :next_node

    def initialize(value = nil, next_node = nil)
        @value = value
        @next_node = next_node
    end
end

class LinkedList
    attr_reader :head, :tail, :size

    def initialize
        @head = Node.new
        @tail = @head
        @size = 0
    end

    def append(value)
        @size += 1
        if @head == @tail && @head.value.nil?
            @head.value = value
        else
            @tail.next_node = Node.new(value)
            @tail = @tail.next_node
        end
    end

    def prepend(value)
        @size += 1
        if @head == @tail && @head.value.nil?
            @head.value = value
        else
            @head = Node.new(value, @head)
        end
    end

    def at(index)
        return if index >= size
        current_node = @head
        index.times { current_node =  current_node.next_node }
        current_node
    end
    
    def pop
        if @head == @tail
            @head.value = nil
            @size = 0
        else
            @size -= 1
            current_node = @head
            until current_node.next_node == @tail do
                current_node = current_node.next_node
            end
            current_node.next_node = nil
            @tail = current_node
        end
    end

    def contains?(value)
        current_node = @head
        found = false
        until current_node.nil? || found do
            if value == current_node.value
                found = true
            else
                current_node = current_node.next_node
            end
        end
        found
    end

    def find(value)
        index = 0
        current_node = @head
        found = false
        until current_node.nil? || found do
            if value == current_node.value
                found = true
            else
                current_node = current_node.next_node
                index += 1
            end
        end
        if index == size
            return
        else
            return index
        end
    end

    def to_s
        output = ""
        unless head.value.nil?
            current_node = @head
            until current_node.next_node.nil? do
                output += "( #{current_node.value} ) -> "
                current_node = current_node.next_node
            end
            output += "( #{current_node.value} ) -> "
        end
        output += "nil"
    end

    def insert_at(value, index)
        if index > size || index < 0
            puts "index #{index} is out of bounds, unable to insert node"
            return
        end
        if index == 0
            prepend(value)
        else
            @size += 1
            at(index - 1).next_node = Node.new(value, at(index - 1).next_node)
            @tail = @tail.next_node if index == size - 1
        end
    end

    def remove_at(index)
        if index > size - 1 || index < 0
            puts "index #{index} is out of bounds, unable to remove node"
            return
        end
        if index == size - 1
            pop
        else
            @size -= 1
            if index == 0
                @head = @head.next_node
            else
                at(index - 1).next_node = at(index).next_node
            end
        end
    end
end