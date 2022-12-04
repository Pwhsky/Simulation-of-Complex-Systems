%Discrete white noise
%Random walker with gaussian steps

clear
clf
tic

time = 5;
dt_list = [0.01 0.05 0.1];


figure(1)
sgtitle('Random walks with gaussian steps')

for i =  1:3
    
    time_steps = time/dt_list(i);
    
    y = 1:time_steps;
    x = zeros(1,time_steps);
    subplot(1,3,i)
    xlabel('$t$','Interpreter','latex','FontSize',10)
    ylabel('$\Delta x$','Interpreter','latex')
    hold on
    
    hold on
for walkers = 1:50
    
for t= 2:time_steps
    r = randn;
       x(t) = x(t-1)  + r*sqrt(dt_list(i));
end
plot(y,x,'color','blue','LineWidth',1)
 
    
end

end



%Calculate Mean square distance as a function of time steps taken
figure(2)
sgtitle('MSD over time')

for i =  1:3
    dt = dt_list(i);
    time_steps = time/dt;
    
    squared_distance = zeros(1,time_steps);
    squared_distance_vector = zeros(1,time_steps);
    

   
    subplot(1,3,i)
   
    xlabel('$\Delta t$','Interpreter','latex')
    ylabel('$\overline{x} ^2$','Interpreter','latex')
    ylim([0,5.1])
    hold on
for walkers = 1:1e4
     x = zeros(1,time_steps);
    
for t= 2:time_steps
    r = randn;
       x(t) = x(t-1)  + r*sqrt(dt);
       squared_distance(t) = x(t).^2;
end

squared_distance_vector = squared_distance_vector + squared_distance./1e4;


end

plot(1:time_steps,squared_distance_vector,'LineWidth',2,'color','red' );

end

toc