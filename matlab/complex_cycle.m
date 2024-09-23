function plot_fixed_point_complex_cycle()
    % Number of points
    N = 12*16;
    offset = 0;

    % Convert offset from degrees to radians
    offset_rad = deg2rad(offset);

    test = fi(1/24, 1, 34, 37);
    disp(bin(test));

    % Generate N equally spaced points on the complex unit circle with an offset
    theta = linspace(0, 2*pi, N+1) + offset_rad; % N+1 to include the starting point twice
    points = exp(1j * theta(1:end-1)); % exp(j*theta) gives points on the unit circle

    % Convert to 16-bit fixed-point numbers
    fixed_points_real = fi(real(points), 1, 16, 15); % Signed, 16-bit, 15 fractional bits
    fixed_points_imag = fi(imag(points), 1, 16, 15); % Signed, 16-bit, 15 fractional bits

    % Combine real and imaginary parts
    fixed_points = fixed_points_real + 1j * fixed_points_imag;

    % Print the fixed-point binary values and original complex values
    disp('The equally spaced points on the complex unit circle in 16-bit fixed-point are:');
    % Open two files for writing
    fid_real = fopen('real_points.txt', 'w');
    fid_imag = fopen('imag_points.txt', 'w');
    
    for i = 1:N
        % Convert real and imaginary fixed points to binary format
        real_binary = bin(fixed_points_real(i));
        imag_binary = bin(fixed_points_imag(i));
        
        % Write to real part file
        fprintf(fid_real, "assign point_re[%03d] = 'b%s; // (%.4f)\n", i-1, real_binary, real(points(i)));
        
        % Write to imaginary part file
        fprintf(fid_imag, "assign point_im[%03d] = 'b%s; // (%.4f)\n", i-1, imag_binary, imag(points(i)));
    end
    
    % Close files
    fclose(fid_real);
    fclose(fid_imag);

    % Plot the points on the complex plane and draw lines from the center
    figure;
    plot(real(fixed_points), imag(fixed_points), 'bo'); % Plot the points
    hold on;
    for i = 1:N
        plot([0, real(fixed_points(i))], [0, imag(fixed_points(i))], 'r-'); % Draw lines from center to each point
        % Display angle as a/N π
        angle_fraction = i-1; % Since we divide the circle into N equal parts
        text(real(fixed_points(i)), imag(fixed_points(i)), ...
            sprintf('%d/%d π', angle_fraction, N), ...
            'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    end
    axis([-1 1 -1 1]); % Fixed axis boundaries
    grid on;
    title('Equally Spaced Points on the Complex Unit Circle');

    xlabel('Real');
    ylabel('Imaginary');
    hold off;
end
