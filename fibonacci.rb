def fibs(number_of_members)
    iteration, a, b, result = 1, 1, 1, []
    while iteration <= number_of_members
        if iteration > 2
            a, b = b, a + b
        end
        result << b
        iteration += 1
    end
    return result
end

def fibs_rec(number_of_members)
    return [1] * number_of_members if number_of_members <= 2
    result = fibs_rec(number_of_members - 1)
    result.push(result[-1] + result[-2])
end