function [I] = Simpson(x,y)
% I= integral approximation (approximation of summation of data range
% x= x coordinate of data points
% y= y coordinate of data points

% check for correct number of inputs
if nargin ~=2
    error('must have exactly two inputs')
end

% check that inputs are the same length
if length(x)~=length(y)
    error('inputs must be the same length')
end

% check that x values are evenly spaced
dx=diff(x);
if max(dx)-min(dx)>1e-13 % accounting for matlab computational error
    error('x values must be equally spaced')
end
% establish use of data points
a=x(1); % first x value
b=x(end); % last x value
y0=y(1); % first y value/ f(x) initial
yi=y(2:2:end-1); % odd numbered y values excluding 1st/ f(xi)
yj=y(3:2:end-1); % even numbered y values excluding last/ f(xj)
yf=y(end); % last y value/ f(x) final
N=length(x); % number of x values
n=N-1; % number of intervals

% Simpsons 1/3 composite formula with no trap rule
if mod(n,2)==0 % even number of intervals
    i=((b-a)*(((y0)+(4*sum(yi))+(2*sum(yj))+(yf))/(3*n)));

% Simpsons 1/3 composite with trap function to compute last interval
elseif mod(n,2)==1 % odd number of intervals
    warning('odd number of intervals, trap rule is being used for last interval')
    b=x(end-1); % last x value shifted
    yj=y(3:2:end-2); % f(xj) values shifted
    yf=y(end-1); % f(x) final shifted
    c=x(end-1); % odd interval x1
    d=x(end); % odd interval x2
    fc=y(end-1); % odd interval f(x1)
    fd=y(end); % odd interval f(x2)
    n=n-1; % number of intervals adjusted
    i=((b-a)*(((y0)+(4*sum(yi))+(2*sum(yj))+(yf))/(3*n))); % Simpsons portion
    t=((d-c)*(((fc)+(fd))/2)); % Trap portion
    i=i+t;
end
I=i;
end

