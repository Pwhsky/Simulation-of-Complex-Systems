%Active Brownian particle

clear
tic
dt = 1e-2;
D_T = 2*1e-13;
D_R = 0.5;

velocity = 1e-6;

time_steps = 1e4;

figure(1)
hold on
for i = 0:3
    v = i*velocity;
    
x = zeros(1,time_steps);
y= zeros(1,time_steps);
phi = zeros(1,time_steps);

for t = 1:time_steps
    
    phi(t+1) = phi(t) + sqrt(2*D_R*dt)*randn;
    x(t+1) = x(t) + v*cos(phi(t+1))*dt + sqrt(2*D_T*dt)*randn; 
    y(t+1) =  y(t) + v*sin(phi(t+1))*dt + sqrt(2*D_T*dt)*randn; 
    
end
subplot(1,4,i+1)
plot(x,y)
xlabel('X [m]','interpreter','latex')
ylabel('Y [m]','interpreter','latex')

titlestring = sprintf('V = %g m/s', v);
title(titlestring)
end






figure(3)
%Change D_t
diffusion_t = 1*1e-13;
velocity = 0;

hold on

for i = 0:3
    D_T = 2*i*diffusion_t;
    
x = zeros(1,time_steps);
y= zeros(1,time_steps);
phi = zeros(1,time_steps);

for t = 1:time_steps
    
    phi(t+1) = phi(t) + sqrt(2*D_R*dt)*randn;
    x(t+1) = x(t) + v*cos(phi(t+1))*dt + sqrt(2*D_T*dt)*randn; 
    y(t+1) =  y(t) + v*sin(phi(t+1))*dt + sqrt(2*D_T*dt)*randn; 
    
end
subplot(1,4,i+1)
plot(x,y)
xlabel('X [m]','interpreter','latex')
ylabel('Y [m]','interpreter','latex')

titlestring = sprintf('D_T = %g \n V = 0 ', D_T);
title(titlestring)
end
figure(4)
%Change D_R
diffusion_t = 2*1e-13;

velocity = 0;

hold on

for i = 0:3
    D_R = i/2;
    
x = zeros(1,time_steps);
y= zeros(1,time_steps);
phi = zeros(1,time_steps);

for t = 1:time_steps
    
    phi(t+1) = phi(t) + sqrt(2*D_R*dt)*randn;
    x(t+1) = x(t) + v*cos(phi(t+1))*dt + sqrt(2*D_T*dt)*randn; 
    y(t+1) =  y(t) + v*sin(phi(t+1))*dt + sqrt(2*D_T*dt)*randn; 
    
end
subplot(1,4,i+1)
plot(x,y)
xlabel('X [m]','interpreter','latex')
ylabel('Y [m]','interpreter','latex')

titlestring = sprintf('D_R = %g \n V = 0 ', D_R);
title(titlestring)
end








toc
