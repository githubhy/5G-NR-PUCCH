% Open a file to write the results
fileID = fopen('cordic_atan.txt', 'w');

for x = 0:9
    % Calculate the binary representation of atan(1/(2^x))/(2*pi)
    a = atan(1/(2^x))/(2*pi);
    b = bin(fi(a,1,20,19));
    % Write the result to the file
    fprintf(fileID, 'atan(1/(2^%1d))/(2*pi) = %.6f (%s)\n', x, a, b);
end

% Close the file
fclose(fileID);
