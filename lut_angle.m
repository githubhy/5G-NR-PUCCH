% Set up the parameters
ITERATIONS = 16;
n_bits = 34;          % Total number of bits (1 integer bit + 33 fractional bits)
fractional_bits = 30; % Number of fractional bits
binary_list = strings(1, ITERATIONS); % Preallocate list for binary results

% Loop through values of i from 0 to 16
for i = 0:ITERATIONS-1
    % Compute the value of atan(1 / 2^i)
    fi = atan(1 / 2^i);
    
    % Convert to fixed-point with specified format
    fi_fixed = fi * 2^fractional_bits; % Scale by 2^fractional_bits
    fi_fixed_int = round(fi_fixed);    % Round to the nearest integer
    
    % Convert the result to binary
    bin_rep = fi_fixed_int >= 0; % Positive or zero
    if ~bin_rep
        bin_rep = mod(bitcmp(abs(fi_fixed_int), n_bits) + 1, 2^n_bits); % Two's complement for negative
    end
    bin_str = dec2bin(fi_fixed_int, n_bits); % Convert to binary string
    
    % Store the binary string in the list
    binary_list(i+1) = bin_str;
    
    % Print out the binary string
    fprintf('i = %.2d, atan(1/(2^%.2d)) in binary: %s (%.10f)\n', i, i, bin_str, fi);
end

% Display the binary list
disp('Binary list:');
disp(binary_list);
