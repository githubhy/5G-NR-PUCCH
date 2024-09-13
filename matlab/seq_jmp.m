function seq_jmp()
    x = 60;
    % Generate the combination array
    arr = get_comb(x);
    
    % Count the occurrences of each value from 0 to 30
    count_dict = count(arr);
    
    % Print the array
    % disp('Array:');
    % disp(arr);
    
    % Print the count dictionary
    % disp('Count Dictionary:');
    disp(count_dict);
    
    % Print the counts as a binary string
    print_count(count_dict);
end

function arr = get_comb(x)
    % Initialize the array
    arr = [];
    % Call the recursive helper function
    arr = get_comb_helper(x, arr);
end

function arr = get_comb_helper(x, arr)
    if x < 31
        arr(end+1) = x;  % Append x to arr
    else
        for i = 0:3
            arr = get_comb_helper(x - 28 - i, arr);
        end
    end
end

function count_dict = count(arr)
    % Create an array to store the count of each value from 0 to 30
    count_dict = zeros(1, 31);
    
    % Iterate over the list and update the count for each value in the range
    for i = 1:length(arr)
        num = arr(i);
        if num >= 0 && num <= 30
            count_dict(num + 1) = count_dict(num + 1) + 1;
        end
    end
end

function print_count(count_dict)
    % Create a string to hold the binary representation
    prt_str = '';
    
    % Iterate over count_dict and create the binary string
    for i = 1:length(count_dict)
        if mod(count_dict(i), 2) == 1
            prt_str = strcat(prt_str, '1');
        else
            prt_str = strcat(prt_str, '0');
        end
    end
    
    % Print the binary string
    disp('Coeffs [a0:a30]:');
    disp(prt_str);
end
