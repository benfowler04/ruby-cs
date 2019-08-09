class Square
    attr_reader :position
    attr_accessor :knight_neighbors, :previous_square

    def initialize(column, row)
        @position = [column, row]
        @knight_neighbors = []
        @previous_square = nil
    end
end

class Board
    def initialize
        @squares = []
        for column in 1..8 do
            for row in 1..8 do
                @squares.push(Square.new(column, row))
            end
        end
    end

    def knight_moves(start_position, target_position)
        if start_position == target_position
            puts "Those are the same positions. No moves needed!"
            return
        elsif start_position[0] < 1 || start_position[0] > 8 || start_position[1] < 1 || start_position[1] > 8
            return invalid_position(start_position)
        elsif target_position[0] < 1 || target_position[0] > 8 || target_position[1] < 1 || target_position[1] > 8
            return invalid_position(target_position)
        end
        start_square = @squares[(start_position[0] - 1) * 8 + start_position[1] - 1]
        squares = [start_square]
        visited_squares = []
        current_square = squares.shift
        current_index = @squares.find_index(current_square)
        target_square = @squares[(target_position[0] - 1) * 8 + target_position[1] - 1]
        until current_square == target_square
            current_square.knight_neighbors.push(@squares[current_index - 17]) unless current_index < 17 || (current_index + 1) % 8 < 2
            current_square.knight_neighbors.push(@squares[current_index - 15]) unless current_index < 15 || (current_index + 1) % 8 == 0
            current_square.knight_neighbors.push(@squares[current_index - 10]) unless current_index < 10 || (current_index + 1) % 8 < 3
            current_square.knight_neighbors.push(@squares[current_index - 6]) unless current_index < 6 || (current_index + 1) % 8 > 6
            current_square.knight_neighbors.push(@squares[current_index + 6]) unless current_index > 57 || (current_index + 1) % 8 < 3
            current_square.knight_neighbors.push(@squares[current_index + 10]) unless current_index > 53 || (current_index + 1) % 8 > 6
            current_square.knight_neighbors.push(@squares[current_index + 15]) unless current_index > 48 || (current_index + 1) % 8 < 2
            current_square.knight_neighbors.push(@squares[current_index + 17]) unless current_index > 46 || (current_index + 1) % 8 == 0
            visited_squares.push(current_square)
            current_square.knight_neighbors.each do |neighbor|
                squares.push(neighbor) unless visited_squares.include?(neighbor) || squares.include?(neighbor)
                neighbor.previous_square = current_square unless visited_squares.include?(neighbor)
            end
            current_square = squares.shift
            current_index = @squares.find_index(current_square)
        end
        moves = []
        until current_square.previous_square.nil?
            moves.unshift(current_square.position)
            current_square = current_square.previous_square
        end
        moves.unshift(current_square.position)
        puts "It takes #{moves.length - 1} moves to go from #{start_position} to #{target_position}:"
        moves.each { |position| print position; puts }
    end

    private
    def invalid_position(position)
        puts "Position #{position} is invalid."
    end
end