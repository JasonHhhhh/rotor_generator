%% Function to calculate class and shape function
function [y] = ClassShape(w,x,N1,N2,dz)


% Class function; taking input of N1 and N2
for i = 1:size(x,1)
    C(i,1) = x(i)^N1*((1-x(i))^N2);
end

% Shape function; using Bernstein Polynomials
n = size(w,2)-1; % Order of Bernstein polynomials

for i = 1:n+1
     K(i) = factorial(n)/(factorial(i-1)*(factorial((n)-(i-1))));
end

for i = 1:size(x,1)
    S(i,1) = 0;
    for j = 1:n+1
        S(i,1) = S(i,1) + w(j)*K(j)*x(i)^(j-1)*((1-x(i))^(n-(j-1)));
    end
end

% Calculate y output
for i = 1:size(x,1)
   y(i,1) = C(i,1)*S(i,1) + x(i)*dz;
end



