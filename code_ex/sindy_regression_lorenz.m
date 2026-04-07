%% Generate Lorenz data
sigma = 10;  beta = 8/3;  rho = 28;
% sigma = 12;  beta = 7/3;  rho = 26;
lorenz = @(t,x) [sigma*(x(2)-x(1));
                 x(1)*(rho-x(3))-x(2);
                 x(1)*x(2)-beta*x(3)];

dt = 0.001;
tspan = 0:dt:50;
x0 = [-8; 7; 27];
[t, x] = ode45(lorenz, tspan, x0);

%% Compute derivatives (finite differences)
dx = zeros(size(x));
for i = 2:length(t)-1
    dx(i,:) = (x(i+1,:) - x(i-1,:)) / (2*dt);
end
dx = dx(2:end-1, :);
x  = x(2:end-1, :);

%% SINDy
polyorder = 3;
usesine   = 0;
nVars     = 3;
lambda    = 0.025;   % sparsification threshold

Theta = poolData(x, nVars, polyorder, usesine);   % build library
Xi    = sparsifyDynamics(Theta, dx, lambda, nVars); % identify Xi

%% Print results
labels = poolDataList({'x','y','z'}, nVars, polyorder, usesine);
for i = 1:nVars
    fprintf('\ndx%d/dt = ', i);
    for j = 1:length(Xi)
        if abs(Xi(j,i)) > 1e-10
            fprintf('+ %.4f %s ', Xi(j,i), labels{j});
        end
    end
end