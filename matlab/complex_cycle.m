function plot_fixed_point_complex_cycle()
    % Number of points
    N = 2;
    offset = 45;

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
    for i = 1:N
        real_binary = bin(fixed_points_real(i));
        imag_binary = bin(fixed_points_imag(i));
        fprintf('Point %2d: Real = %s (%.4f), Imaginary = %s (%.4f)\n', ...
            i, real_binary, real(points(i)), imag_binary, imag(points(i)));
    end

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
