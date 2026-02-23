% These lines will not be shown in the listing within the document.
%
%

% Sample MATLAB code

% Create a 2D grid
[X,Y] = meshgrid(-2:.2:2, -2:.2:2);

% Compute the function
Z = X .* exp(-X.^2 - Y.^2);

% Display the surface
surf(X,Y,Z);

% Add labels
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('A 3D plot of the function X \cdot e^{-X^2 - Y^2}');