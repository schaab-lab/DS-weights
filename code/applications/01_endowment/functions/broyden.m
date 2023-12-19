function [x, xhist] = broyden(fun,x0,varargin)
% Solves system of nonlinear equations fun(X) = 0 by Broyden's method
% Broyden's method is a quasi-Newton method which updates an approximate 
% Jacobian at each new Newton step. Only real-valued solutions accepted.
%  
% Usage:
%  x = broyden(fun,x0)
%    fun is a handle to a function returning a column vector f
%       of function values
%    x0 is the column vector of starting values for the search.
%    x is the solution, if one is found. Otherwise, broyden issues a 
%       warning; "No convergence" and returns a vector of NaNs
%    f, x0 and x are all column vectors of length n. J is n by n.
%  x = broyden(fun,x0,name,value, ...)
%    allows the user to control the iteration.  
%    The following names are allowed:
%      bounds: n by 2 matrix where bounds(i,1) and bounds(i,2) are 
%        lower and upper bounds, respectively, for variable i.   
%        Use -Inf and/or Inf to indicate no bound.  Default: No bounds.
%      maxiter: Maximum number of iterations,  Default: 50
%      tolx:    Minimum length of last iteration step. Default: 1e-4
%      tolfun:  Minimum value for norm(f). Default: 1e-5
%    Example: x = broyden(fun,x0,'maxiter',100,'tolfun',1e-3) 
%  [x, xhist] = f(fun,x0,...)
%     xhist contains the search history. x(k,i) is x(i) at iteration k
%
% Example:
%  fun = @(x) [x(1)^2 + x(2)^2 - 4; exp(x(1)) + x(2) - 1];
%  x = broyden(fun,[1;1])
%  A second root has x(1) > 0, x(2) < 0.  This may be found by selecting  
%  another initial value x0, or by using bounds.  E.g.:
%  [x,xhist] = broyden(fun,[1;1],'bounds',[0,2;-3,-1]);
%
%  See also: newton
%             (https://se.mathworks.com/matlabcentral/fileexchange/82320)
%             fsolve (in optimization toolbox)

%  Author: Are Mjaavatten, 
% 
%  The update formula for the Jacobian J is taken from p399 in 
%  Matthias Heinkenschloss: Lecture Notes - Numerical Analysis II
%  https://bpb-us-e1.wpmucdn.com/blogs.rice.edu/dist/8/4754/files/2019/01/CAAM-454-554-1lvazxx.pdf
%
% Version 1:   2015-12-29
% Version 1.1: 2016-11-29 Added iteration history
% Version 1.2: 2020-11-04 New handling of convergence parameters
% Version 1.3: 2020-12-19 New handling of bounds
% Version 2.0: January 2021 Improved robustness. Better error handling
% Version 2.01: 2023-05-18; Replaced broken link to Matthias Heinkenschloss

  % Parse any name-value pairs that will override the defaults:
  p = inputParser;
  addParameter(p,'tolfun',1e-5);  % Last argument is the default value
  addParameter(p,'tolx',1e-4);
  addParameter(p,'maxiter',50);
  addParameter(p,'bounds',[]);

  parse(p,varargin{:})
  opt = p.Results;    
  % Fields of opt take the default values unless overriden by a 
  % name/value pair
  
  bnds = ~isempty(opt.bounds);  % Bounds on x
  if any(diff(opt.bounds')<0)
    error('newton:bounds',...
      'bounds(i,2)-bounds(i,1) must be > 0 for all i')
  end  
  if bnds && ~all(isreal(opt.bounds))
    warning('newton:complexbounds','Bounds cannot be complex numbers')
  end							 
  x = x0(:);
  f = fun(x);
  if ~(size(x) == size(f))
    error('broyden:dimension',...
      'fun must return a column vector of the same size as x0')
  end  
  J = jacobi(fun,x);  % Initial Jacobian matrix
  xhist = zeros(opt.maxiter,length(x));
  for i = 1:opt.maxiter
    xhist(i,:) = x';  % Search history			  bnds
    if any(isnan(J(:))) || rcond(J) < 1e-15
      J = jacobi(fun,x); % Try with a full Jacobian
      if any(isnan(J(:))) || rcond(J) < 1e-15
        warning('broyden:singular',...'
		        'Singular jacobian at iteration %d.\n Iteration stopped.',i);
        x = NaN*x0;
        return
      end
    end
    dx = -J\f(:);
    if bnds
      xnew = real(x + dx);
      xnew = min(max(xnew,opt.bounds(:,1)),opt.bounds(:,2));
      dx = xnew-x;
    end
    x  = x+dx;
    if norm(f(:))<opt.tolfun && norm(dx)<opt.tolx
      xhist = xhist(1:i,:);
      if norm(fun(real(x)))> opt.tolfun  % Complex part not negligible
        warning('Converged to complex solution')
      else
        x = real(x);
      end
      return
    end 
    f  = fun(x);
    J  = J + f*dx'/(dx'*dx);  
  end
  if any(abs(xhist(end-1,:)-xhist(end,:))<= 1e-8) 
    s1 = 'Search stuck. ';
    s2 = 'Possibly because Newton step points out of bounded region.';
    if bnds
      warning('broyden:stuck',[s1,s2,'\nNo convergence']);
    else
      warning('broyden:stuck',[s1,'\nNo convergence']);
    end
    fprintf('Last x:\n')
    for k = 1:numel(x)
      fprintf('%f\n',x(k))
    end
	x = x*NaN;
  else
    warning('broyden:noconv','No convergence.')
  end
end

function J = jacobi(f,x,delta)
% Simple Jacobian matrix estimate using central differences
%  f: function handle
%  x: column vector of independet variables
%  delta: Optional step leghth.  Default: 1e-7*sqrt(norm(x))
%
% See also: John D'Errico's jacobianest.m in
%   https://www.mathworks.com/matlabcentral/fileexchange/13490
%   (Robust and high accuracy)

  if nargin < 3
      delta = 1e-7*sqrt(norm(x));
  end
  y0 = feval(f,x);
  n = length(y0);
  m = length(x);
  J = zeros(n,m);
  X = repmat(x,[1,m]);
  d = delta/2*eye(m);
  for i = 1:m
    J(:,i) = (f(X(:,i)+d(:,i))-f(X(:,i)-d(:,i)))/delta;
  end
end