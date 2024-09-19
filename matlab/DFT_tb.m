uciCW = [
    1;
    0;
    1;
    0;
    1;
    1;
    1;
    0;
    1;
    0;
    1;
    0;
    0;
    1;
    1;
    0;
    1;
    0;
    0;
    1;
    1;
    0;
    1;
    0;
    0;
    0;
    1;
    0;
    0;
    1;
    1;
    0;
    0;
    1;
    1;
    0;
    1;
    1;
    0;
    1;
    1;
    1;
    0;
    1;
    0;
    1;
    0;
    1
];

nid   = 512;  % 10 bit
rnti  = 56789; % 16 bit
Mrb   = 1; % Msc = Mrb * nRBSC with nRBSC = 12

% Set interlacing specific parameters to empty as they are not
% supported in this function.
sf   = [];
occi = [];

modulation = 'QPSK';
% modulation = 'pi/2-BPSK';

% Scrambling, TS 38.211 Section 6.3.2.6.1
c = nrPUCCHPRBS(nid,rnti,length(uciCW));
btilde = xor(uciCW,c);

% Modulation, TS 38.211 Section 6.3.2.6.2
d = nrSymbolModulate(btilde,modulation);

% Calculate the normalized angle in terms of 24 cycles
cyc_24_angle = angle(d) / (2 * pi) * 24;
% If the angle is negative, adjust it to make it positive
cyc_24_angle(cyc_24_angle < 0) = 24 + cyc_24_angle(cyc_24_angle < 0);
% Open the file for writing
fid = fopen('cyc_24_angle.txt', 'w');
% Write each value of cyc_24_angle into the file, one per line
for i = 1:length(cyc_24_angle)
    fprintf(fid, '%.4f\n', cyc_24_angle(i));  % Write the value with 4 decimal places
end

% Close the file
fclose(fid);

y = d;

in = y;

% Get the number of subcarriers
Msc = double(Mrb)*12;

% Perform transform precoding
xtilde0 = reshape(in,Msc,numel(in)/Msc);
xtilde0_fft = fft(xtilde0);
out = xtilde0_fft/sqrt(Msc);

disp(xtilde0);
disp(out);

% Reshape xtilde0 and xtilde0_fft into a single column (vectorize)
xtilde0_vector = xtilde0(:);
xtilde0_fft_vector = xtilde0_fft(:);

xtilde0_re_file = fopen('xtilde0_re.txt', 'w');
xtilde0_im_file = fopen('xtilde0_im.txt', 'w');
for xtilde0_index = 1:length(xtilde0_vector)
    point = xtilde0_vector(xtilde0_index);
    point_re = real(point);
    point_im = imag(point);
    % disp(point_re);
    % disp(point_im);
    hex_re = hex(fi(point_re,1,20,15));
    hex_im = hex(fi(point_im,1,20,15));
    % disp(hex_re);
    % disp(hex_im);
    fprintf(xtilde0_re_file, "%s\n", hex_re);
    fprintf(xtilde0_im_file, "%s\n", hex_im);
end
fclose(xtilde0_re_file);
fclose(xtilde0_im_file);

xtilde0_fft_re_file = fopen('xtilde0_fft_re.txt', 'w');
xtilde0_fft_im_file = fopen('xtilde0_fft_im.txt', 'w');
for xtilde0_fft_index = 1:length(xtilde0_fft_vector)
    point = xtilde0_fft_vector(xtilde0_fft_index);
    point_re = real(point);
    point_im = imag(point);
    % disp(point_re);
    % disp(point_im);
    hex_re = hex(fi(point_re,1,20,15));
    hex_im = hex(fi(point_im,1,20,15));
    % disp(hex_re);
    % disp(hex_im);
    fprintf(xtilde0_fft_re_file, "%s\n", hex_re);
    fprintf(xtilde0_fft_im_file, "%s\n", hex_im);
end
fclose(xtilde0_fft_re_file);
fclose(xtilde0_fft_im_file);

% 
% % Real and imaginary parts for xtilde0
% real_xtilde0 = real(xtilde0_vector);
% imag_xtilde0 = imag(xtilde0_vector);
% 
% % Real and imaginary parts for xtilde0_fft
% real_xtilde0_fft = real(xtilde0_fft_vector);
% imag_xtilde0_fft = imag(xtilde0_fft_vector);
% 
% % Convert to fixed-point format with signed, 16-bit, and 15 fractional bits
% fi_real_xtilde0 = fi(real_xtilde0, 1, 20, 15);
% fi_imag_xtilde0 = fi(imag_xtilde0, 1, 20, 15);
% fi_real_xtilde0_fft = fi(real_xtilde0_fft, 1, 20, 15);
% fi_imag_xtilde0_fft = fi(imag_xtilde0_fft, 1, 20, 15);
% 
% % Convert fixed-point numbers to hexadecimal format
% hex_real_xtilde0 = hex(fi_real_xtilde0);
% hex_imag_xtilde0 = hex(fi_imag_xtilde0);
% hex_real_xtilde0_fft = hex(fi_real_xtilde0_fft);
% hex_imag_xtilde0_fft = hex(fi_imag_xtilde0_fft);
% 
% % Write real and imaginary parts of xtilde0 to files, row by row
% fid_real_xtilde0 = fopen('xtilde0_real.txt', 'w');
% for i = 1:length(hex_real_xtilde0)
%     fprintf(fid_real_xtilde0, '%s\n', hex_real_xtilde0);  % Direct indexing using parentheses
% end
% fclose(fid_real_xtilde0);
% 
% fid_imag_xtilde0 = fopen('xtilde0_imag.txt', 'w');
% for i = 1:length(hex_imag_xtilde0)
%     fprintf(fid_imag_xtilde0, '%s\n', hex_imag_xtilde0);  % Direct indexing using parentheses
% end
% fclose(fid_imag_xtilde0);
% 
% % Write real and imaginary parts of xtilde0_fft to files, row by row
% fid_real_xtilde0_fft = fopen('xtilde0_fft_real.txt', 'w');
% for i = 1:length(hex_real_xtilde0_fft)
%     fprintf(fid_real_xtilde0_fft, '%s\n', hex_real_xtilde0_fft);  % Direct indexing using parentheses
% end
% fclose(fid_real_xtilde0_fft);
% 
% fid_imag_xtilde0_fft = fopen('xtilde0_fft_imag.txt', 'w');
% for i = 1:length(hex_imag_xtilde0_fft)
%     fprintf(fid_imag_xtilde0_fft, '%s\n', hex_imag_xtilde0_fft);  % Direct indexing using parentheses
% end
% fclose(fid_imag_xtilde0_fft);
% 
