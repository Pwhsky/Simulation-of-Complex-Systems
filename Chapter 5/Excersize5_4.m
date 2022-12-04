%Brownian particle
tic
clf
clear

eta = 0.001;
R = 1e-6;
gamma = 6*pi*eta*R;
T = 300;
kX =  1e-6;
kY = 0.25*1e-6;
kb = 1.380649*10^-23;
time_steps = 1e5;


x = zeros(1,time_steps);
y = zeros(1,time_steps);


dtX = 0.2*gamma/kX;
dtY = 0.2*gamma/kY;

figure(1)

sgtitle('Brownian motion of optically trapped particle')
for t= 2:time_steps
    r = randn;
    x(t) = x(t-1) - kX*x(t-1)*dtX/gamma + sqrt(2*kb*T*dtX/gamma)*r;
       r = randn;
       
    y(t) = y(t-1) - kY*y(t-1)*dtY/gamma + sqrt(2*kb*T*dtY/gamma)*r;
end



subplot(1,4,1)
%Plot positions of the particle
scatter(x,y,2,"filled")
xlabel('x [m]')
ylabel('y [m]')


subplot(1,4,2)
hold on
%Plot probability distribution


varianceX = var(x);
varianceY = var(y);

x_line = linspace(-4*1e-7,4*1e-7,time_steps);
y_line = linspace(-4*1e-7,4*1e-7,time_steps);


%Plot theoretical values for boltzmann distribution:
U_x = 0.5*kX.*x_line.^2;
P_x = exp(-U_x./(kb*T));

U_y = 0.5*kY.*y_line.^2;
P_y = exp(-U_y./(kb*T));


plot(x_line,P_x,'--','color','k','linewidth',2)
plot(y_line,P_y,'--','color','k','linewidth',2)




gaussX = exp(-0.5*x_line.^2 ./varianceX);
gaussY = exp(-0.5*y_line.^2 ./varianceY);
plot(y_line,gaussY)
plot(x_line,gaussX)


legend('','','Y','X')
xlabel('x,y [m]')
ylabel('P')



%------------------------------------------------------
%Plot autocorrelation function
subplot(1,4,3)
%Theory first:
time = linspace(0,0.3,time_steps);
C_x = kb*T/kX .* exp(-kX.*time./gamma);
C_y = kb*T/kY .* exp(-kY.*time./gamma);

plot(time,C_x,'--','color','k','linewidth',2)
hold on
plot(time,C_y,'--','color','k','linewidth',2)

%Now sample:


x_avg = zeros(1,time_steps);
y_avg = zeros(1,time_steps);


for N = 1:200
    
for t = 2:time_steps
   x_avg(t) = x_avg(t) + (x(t)*x(t-1));
   y_avg(t) = y_avg(t) + (y(t)*y(t-1)); 
   
end
end
 %Secondary curve has poor fitting, scales are way off but share
 %characteristics of the theoretical values.


plot(time,sort(x_avg./N,'descend'))

plot(time,sort(y_avg./N,'descend'))
legend('','','$C_x$','$C_y$','interpreter','latex')
xlabel('Time [s]')
ylabel('$C_x , C_y$' ,'Interpreter','latex')
%Now plot the sampled values
subplot(1,4,4)
hold on
%Now simulate 1D for different stiffness values 




for i = 1:2:10
 ki = i*1e-7;
x_avg = zeros(1,time_steps);

for N = 1:50
    
for t= 2:time_steps
    r = randn;
    x(t) = x(t-1) - ki*x(t-1)*dtX/gamma + sqrt(2*kb*T*dtX/gamma)*r; 
end
x_avg = x_avg + x.^2;

end

scatter(ki,sum(x_avg)./(time_steps-N))


end

%theoretical value
k = linspace(0,1e-6,100);
variance = (kb*T).*k.^-1;
plot(k,variance,'--','color','k','linewidth',2)


xlabel('k [N/m]')
ylabel('$\overline{x} ^2$ [m]','Interpreter','latex')

%Unable to fit the correct scales to the sampled values  & the theoretical
%values, though the characteristics are the same.
%--------------------------------------------------------



toc