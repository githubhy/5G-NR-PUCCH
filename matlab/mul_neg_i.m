% Define the complex number
a = 5;  % Real part
b = 3;  % Imaginary part
z = a + b*1i;  % Complex number a + bi

% Multiply by -i
z_mult = z * (-1i);

% Plot the original and the result
figure;
hold on;

% Plot original number
plot(real(z), imag(z), 'bo', 'MarkerSize', 10, 'LineWidth', 2);
text(real(z), imag(z), '  Original (a+bi)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

% Plot result after multiplication by -i
plot(real(z_mult), imag(z_mult), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
text(real(z_mult), imag(z_mult), '  After *(-i)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');

% Customize the plot
xlabel('Real Part');
ylabel('Imaginary Part');
title('Complex Number and Result after Multiplication by -i');
axis equal;
grid on;
xlim([-max(abs([real(z), real(z_mult)]))-1, max(abs([real(z), real(z_mult)]))+1]);
ylim([-max(abs([imag(z), imag(z_mult)]))-1, max(abs([imag(z), imag(z_mult)]))+1]);

hold off;
