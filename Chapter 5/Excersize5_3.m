%Brownian particle in viscous fluid 1D

%Parameters
clear
clf

tic
R = 1e-6;
m = 1.11*1e-14;
eta = 0.001;
gamma = 6*pi*eta*R;
T = 300;
kb = 1.380649*10^-23;


tau = m/gamma; 
dt = 0.01*tau;
time_steps = 100 ;
L = dt*tau^(-1);


figure(1)
 subplot(2,2,1)
    x = zeros(1,time_steps);
    
for t= 3:time_steps
    r = randn;
    
       x(t) = ((2+L)/(1+L))*x(t-1)- ...
           (x(t-2))/(1+ L) +...      
           ((sqrt(2*kb*T*gamma))/(m*(1+L)))*(dt^(3/2))*r;
           
end
plot(1:time_steps,x)
title('With mass term')
xlabel('$100 \tau $','interpreter','latex','fontsize',10)
ylabel('x [m]','interpreter','latex','fontsize',10)
subplot(2,2,2)

    x = zeros(1,time_steps);
for t= 3:time_steps
    r = randn;
    
       x(t) = x(t-1)+ sqrt(2*kb*t*dt/gamma)*r;
           
end

plot(1:time_steps,x)
title('Without mass term')
xlabel('$100 \tau $','interpreter','latex','fontsize',10)
ylabel('x [m]','interpreter','latex','fontsize',10)
    %Now for 100tau
dt = 0.01*tau;
time_steps = 110 ;


 subplot(2,2,3)
    x = zeros(1,time_steps);
    squared_x = zeros(1,time_steps);
    mean_squared1 = zeros(1,time_steps);
    L = dt*tau^(-1);

    
for N = 1:200
    
for t= 3:time_steps
    r = randn;
    
       x(t) = ((2+L)/(1+L))*x(t-1)- ...
       x(t-2)*(1/(1+ L)) +...      
       ((sqrt(2*kb*T*gamma))/(m*(1+L)))*(dt^(3/2))*r;
      
       squared_x(t) = x(t);
           

end

mean_squared1 = mean_squared1 + squared_x.^2;

end

plot(1:time_steps,x)
xlabel('$ \tau $','interpreter','latex','fontsize',10)
ylabel('x [m]','interpreter','latex','fontsize',10)
hold on

subplot(2,2,4)

    x = zeros(1,time_steps);
    squared_x = zeros(1,time_steps);
    mean_squared2 = zeros(1,time_steps);
    
for N = 1:200
   for t= 3:time_steps
    r = randn;
    
       x(t) = x(t-1)+ sqrt(2*kb*t*dt/gamma)*r;
        squared_x(t) = x(t);
           
       
   end
   mean_squared2 = mean_squared2 + squared_x.^2;
end


plot(1:time_steps,x)
xlabel('$ \tau $','interpreter','latex','fontsize',10)
ylabel('x [m]','interpreter','latex','fontsize',10)
%calculate MSD

    
figure(2)
title('Mean square deviation over time')
hold on
xlabel('t')
ylabel('$\overline{x} ^2$ [m]','Interpreter','latex')
    
plot(log(1:time_steps),log(mean_squared1./(time_steps*N) )   )
plot(log(1:time_steps),log(mean_squared2./(time_steps*N) )  )

 legend('intertial','Non-inertial')
%----------------------------------------------------------------------
%Show Ergodicity:

  x = zeros(1,time_steps);
    squared_x = zeros(1,time_steps);
    mean_squared3 = zeros(1,time_steps);

for N = 1:1000
   for t= 3:time_steps
    r = randn;
    
       x(t) = x(t-1)+ sqrt(2*kb*t*dt/gamma)*r;
       squared_x(t) = x(t)^2;
           
       
   end
   mean_squared3 = mean_squared3 + squared_x;
end


 x = zeros(1,time_steps);
    squared_x = zeros(1,time_steps);
    mean_squared4 = zeros(1,time_steps);


   for t= 3:(time_steps*1000)
    r = randn;
    
       x(t) = x(t-1)+ sqrt(2*kb*t*dt/gamma)*r;
       mean_squared4(t) = x(t)^2;

   end
   
%This is meant to show that the cases are similar, but I haven't gotten it to work.
mean_squared3 = mean_squared3./(time_steps*N);
mean_squared4 = mean_squared4./(time_steps*1000);
sum(mean_squared3)
sum(mean_squared4)
%-----------------------------------------------------------------------------------------

 legend('intertial','Non-inertial')




toc