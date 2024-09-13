% Parameters
% nid       = 512; % input
% nslot     = 3;   % input
% nid       = 100; % input
% nslot     = 2;   % input
nid       = 512; % input
nslot     = 0;   % input

nSlotSymb = 14;

% Extract the c(n) sequence needed to compute ncs
get_prbs = nrPRBS(nid, nSlotSymb * 8 * [nslot 1]);

% Get the value of ncs for all the symbols in a slot
ncs = (2.^(0:7)) * reshape(get_prbs, 8, []);

% Number of bits to group in each value
nGenBit = [1 8];

% Write PRBS sequence to file
for n = nGenBit(1:2)
filename_prbs = sprintf('prbs_c_seq_gen_nid%d_nslot%d_nGenBit%d.txt', nid, nslot, n);

% Open file for writing PRBS sequence
fileID_prbs = fopen(filename_prbs, 'w');

% Check if the file opened successfully
if fileID_prbs == -1
    error('Cannot open file for writing PRBS sequence.');
end

% Write PRBS sequence to file (group nGenBit bits, reverse, and write as binary values)
for i = 1:(length(get_prbs)/n)
    % Group nGenBit bits together
    prbs_group = get_prbs((i-1)*n+1 : i*n);
    
    % Convert group to string and remove spaces
    prbs_binary_str = num2str(prbs_group');
    prbs_binary_str = prbs_binary_str(~isspace(prbs_binary_str));
    
    % Reverse the bit string
    prbs_binary_str_reversed = flip(prbs_binary_str);
    
    % Write reversed bit string as binary string to the file
    fprintf(fileID_prbs, '%s\n', prbs_binary_str_reversed);
end

% Close the file
fclose(fileID_prbs);

% Display confirmation for PRBS sequence
disp(['PRBS sequence successfully written to ' filename_prbs ' in binary format.']);

end

% Write ncs sequence in hexadecimal to a separate file
filename_ncs = sprintf('ncs_c_seq_gen_nid%d_nslot%d.txt', nid, nslot);

% Open file for writing ncs values in hexadecimal
fileID_ncs = fopen(filename_ncs, 'w');

% Check if the file opened successfully
if fileID_ncs == -1
    error('Cannot open file for writing ncs values.');
end

% Write ncs values to file (reverse the binary and write in hexadecimal)
for i = 1:length(ncs)
    % Convert ncs value to binary (8 bits per hex digit)
    ncs_binary_str = dec2bin(ncs(i), 8);  % Convert to 8-bit binary string
    
    % Reverse the binary string
    ncs_binary_reversed = flip(ncs_binary_str);
    
    % Convert reversed binary back to hex
    ncs_hex = dec2hex(bin2dec(ncs_binary_str), 2);  % Ensure 2 hex digits
    
    % Write the reversed hexadecimal value to file
    fprintf(fileID_ncs, '%s\n', ncs_hex);
end

% Close the file
fclose(fileID_ncs);

% Display confirmation for ncs sequence
disp(['ncs sequence successfully written to ' filename_ncs ' with reversed binary in hexadecimal format']);
