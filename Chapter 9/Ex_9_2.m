%Active Brownian particle, MSD calculations
clear
tic
dt = 1e-2;
D_T = 2*1e-13;
D_R = 0.5;
v = 3e-6;
time_steps = 1e4;

figure(1)
for i = 0:3
 D_R = i/2;
x = zeros(1,time_steps);
y= zeros(1,time_steps);
phi = zeros(1,time_steps);
MSD = zeros(1,time_steps);


for N = 1:100
    
for t = 1:time_steps-50
    phi(t+1) = phi(t) + sqrt(2*D_R*dt)*randn;
    x(t+1) = x(t) + v*cos(phi(t+1))*dt + sqrt(2*D_T*dt)*randn; 
    y(t+1) =  y(t) + v*sin(phi(t+1))*dt + sqrt(2*D_T*dt)*randn;
    
    MSD(t) =  MSD(t) + ((x(t+50)-x(t))^2 + (y(t+50)-y(t))^2)/2  ;
end
end
subplot(1,4,i+1)

loglog((1:time_steps),sort(MSD./(N)) )

xlabel('t ','interpreter','latex')
ylabel('MSD [m]','interpreter','latex')

titlestring = sprintf('D_R = %g \n V = %g ', D_R,v);
title(titlestring)
end

figure(2)
for i = 0:3
 D_R = 0.5;
 v = i*1e-6
x = zeros(1,time_steps);
y= zeros(1,time_steps);
phi = zeros(1,time_steps);
MSD = zeros(1,time_steps);


for N = 1:100
    
for t = 1:time_steps-50
    phi(t+1) = phi(t) + sqrt(2*D_R*dt)*randn;
    x(t+1) = x(t) + v*cos(phi(t+1))*dt + sqrt(2*D_T*dt)*randn; 
    y(t+1) =  y(t) + v*sin(phi(t+1))*dt + sqrt(2*D_T*dt)*randn;
    
    MSD(t) =  MSD(t) + ((x(t+50)-x(t))^2 + (y(t+50)-y(t))^2)/2  ;
end
end
subplot(1,4,i+1)

loglog((1:time_steps),sort(MSD./(N)) )

xlabel('t','interpreter','latex')
ylabel('MSD [m]','interpreter','latex')

titlestring = sprintf('D_R = %g \n V = %g ', D_R,v);
title(titlestring)
end
xlabel('t')
ylabel('MSD [m]')


%Compare time average to ensemble average:
figure(3)

x = zeros(1,time_steps);
y= zeros(1,time_steps);
phi = zeros(1,time_steps);
MSD = zeros(1,time_steps);

D_R = 0;
for N = 1:100
for t = 1:time_steps-50
    phi(t+1) = phi(t) + sqrt(2*D_R*dt)*randn;
    x(t+1) = x(t) + v*cos(phi(t+1))*dt + sqrt(2*D_T*dt)*randn; 
    y(t+1) =  y(t) + v*sin(phi(t+1))*dt + sqrt(2*D_T*dt)*randn;
    
    MSD(t) =  MSD(t) + ((x(t+50)-x(t))^2 + (y(t+50)-y(t))^2)/2  ;
end
end


loglog((1:time_steps),sort(MSD./N)) 


hold on

x = zeros(1,time_steps);
y= zeros(1,time_steps);
phi = zeros(1,time_steps);
MSD = zeros(1,time_steps);

for t = 1:time_steps-50
    phi(t+1) = phi(t) + sqrt(2*D_R*dt)*randn;
    x(t+1) = x(t) + v*cos(phi(t+1))*dt + sqrt(2*D_T*dt)*randn; 
    y(t+1) =  y(t) + v*sin(phi(t+1))*dt + sqrt(2*D_T*dt)*randn;
    
    MSD(t) =  MSD(t) + ((x(t+50)-x(t))^2 + (y(t+50)-y(t))^2)/2  ;
end

loglog((1:time_steps),sort(MSD)) 

titlestring = sprintf('D_R = %g \n V = %g ', D_R,v);
title(titlestring)
xlabel('X [m]','interpreter','latex')
ylabel('Y [m]','interpreter','latex')

toc
