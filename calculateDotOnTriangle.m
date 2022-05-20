function I = calculateDotOnTriangle(f,g,triangle,area)

coeffs = [2 1 1; 1 2 1; 1 1 2];
f_vec = [f(triangle(1,1),triangle(1,2)), f(triangle(2,1),triangle(2,2)), f(triangle(3,1),triangle(3,2))];
g_vec = [g(triangle(1,1),triangle(1,2)); g(triangle(2,1),triangle(2,2)); g(triangle(3,1),triangle(3,2))];
I = 1/24 * 2 * area * (f_vec * coeffs * g_vec);

end

