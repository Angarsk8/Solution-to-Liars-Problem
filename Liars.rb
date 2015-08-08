#define a global variable to allow the inspection
$PRINT_ARRAY =  true
#asign nil to the $VERBOSE global variable to disable warnings for re-initializing a constant
$VERBOSE = nil

#function that allows the user to input the requested data
def user_prompt(*args)
    print(*args)
    to_return = gets.strip.split
    to_return.collect {|value| Integer(value)}
end

#function that literally evaluates and find the min and max numbers of liars (depends on the parameters)
def find_limit(universe, subset)
    
    large_number = 10_000_000_000
    resource = universe + 1
    my_array = Array.new
    
    (0...universe).each do |value|
        my_array
        .push([value+1, value, 0])
        .push([value, value +1, 1])
    end
    p my_array if $PRINT_ARRAY
    
    (0...universe+1).each do |value|
        my_array.push([resource, value, 0])
    end
    p my_array if $PRINT_ARRAY
    
    subset.each do |value|
        my_array
        .push([value[0]-1,value[1], value[2]])
        .push([value[1],value[0]-1, -value[2]])
    end
    p my_array if $PRINT_ARRAY
    
    distribution = [large_number]*(universe+2)
    distribution[resource] = 0
    
    (0...universe+1).each do |value|
        my_array.each do |value|
            distribution[value[1]] = [distribution[value[1]], distribution[value[0]]+value[2]].min
        end
    end
    distribution[universe]-distribution[0]
end

#start the program and get the prompt of the number of soldiers and the number of subsets
N_M_user_input = user_prompt()#("Number of soldiers and sets of information: ")
N = N_M_user_input[0]
M = N_M_user_input[1]
subsets_input = nil
limit = Array.new
reverse = Array.new

#ask the user for the for the values of each subset [A,B,C]
(1..M).each do |value| 
    subset_input = user_prompt()#("Write the values for A B C respectively separated by a simple space: ")
    A = subset_input[0]
    B = subset_input[1]
    C = subset_input[2]
    limit.push([A,B,C])
    reverse.push([A,B,B-A+1-C])
end

lower_limit = find_limit(N, limit) #calculate the minimun number of liars
upper_limit = N - find_limit(N, reverse) #calculate the maximum number of liars

puts "#{lower_limit} #{upper_limit}"
