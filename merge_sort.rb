def merge_sort(array)
    return array if array.length <= 1
    left = merge_sort(array[0...array.length/2])
    right = merge_sort(array[array.length/2..-1])
    merge(left, right)
end

def merge(left, right)
    result = []
    while left.length > 0 && right.length > 0 do
        if left.first <= right.first
            result.push(left.shift)
        else
            result.push(right.shift)
        end
    end
    if left.length > 0
        result += left
    else
        result += right
    end
    result
end