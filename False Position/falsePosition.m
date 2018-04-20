function [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter)
% False position method to finding root (zeros) of function 
%   inputs:
%       func= the function being evalutated
%       xl= the lower guess
%       xu= the upper guess
%       es= the desired relative error (default to 0.0001%)
%       maxiter= the number of iterations desired (default to 200)
%   outputs:
%       root= the estimated root location
%       fx= the function evaluated at the root location
%       ea= the approximate relative error (%)
%       iter= how many iterations were performed

% argument check to prevent operator error
if nargin<3
    error ('at least three arguments required')
end
% setting defaults
if nargin<4
    es=0.0001; % sets es default to 0.0001
end
if nargin<5
    maxiter=200; % sets maxiter default to 200
end
% Test to make sure user chose bounds that bracket the root
if func(xl)*func(xu)>0
    error ('bounds do not bracket root')
end

% initial input variable conditions
xr=0;
iter=0; % initial value of iteration counter
ea=100; % initial error to get started
while ea>es % repeats until one of the conditions are met
    xrold=xr; % establish xrold for ea calculation
    xr=xu-((double(func(xu))*(xl-xu))/(double(func(xl))-double(func(xu)))); % falseposition formula
    iter=iter+1; % iteration counter
    ea=abs((xr-xrold)/xr)*100; % approximate relative error
    if func(xl)*func(xr)<0 % new subinterval if contains sign change
        xu=xr; % establishes new interval where xr is the upper bound
    elseif func(xu)*func(xr)<0 % new subinterval if contains sign change
        xl=xr; % establishes new interval where xr is the lower bound
    else 
        ea=0; % actual root was found 
    end
    if  iter>maxiter; % if iterations exceed max desired or default terminate
        break
    end
end
root=xr;
fx=func(xr);
end

        
    
    
    
