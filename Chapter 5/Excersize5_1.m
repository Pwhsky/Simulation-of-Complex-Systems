%Simulate Random walks
clf
clear

tic
trials = 500;
figure(1)
sgtitle('Random walks with different types of steps')
subplot(2,3,1)
hold on

y = 1:trials;
x = zeros(1,trials);

final_position = zeros(1,400);
%Coin flips
for coins = 1:1000
    
for t= 2:trials
    r = randi(2);
    
   switch r
       case 1
       x(t) = x(t-1) -1;
       
       case 2
      x(t) = x(t-1)  +1;
    end

end

plot(x,y,'color','blue','LineWidth',1)


    x(t) = 200 + x(t);
   final_position(x(t)) =  final_position(x(t)) +1;
    
 


end
 ylabel('$t$','Interpreter','latex','FontSize',10)
 xlabel('$\Delta x $','Interpreter','latex')
subplot(2,3,4)

bar(final_position,3)
 ylabel('$P(x)$','Interpreter','latex','FontSize',10)
 xlabel('$x + 200 $','Interpreter','latex')

%---------------------------------------------------
final_position = zeros(1,400);
subplot(2,3,2)
hold on
%Gaussian steps
for walkers = 1:1000
    
for step= 2:trials
    r = randn;
       x(step) = x(step-1)  +r;
end
plot(x,y,'color','blue','LineWidth',1)

    x(t) = 200 + round(x(t));
   final_position(x(t)) =  final_position(x(t)) +1;
   
end

 ylabel('$t$','Interpreter','latex','FontSize',10)
 xlabel('$\Delta x $','Interpreter','latex')
subplot(2,3,5)

bar(final_position,3)
 ylabel('$P(x)$','Interpreter','latex','FontSize',10)
 xlabel('$x + 200 $','Interpreter','latex')

final_position = zeros(1,400);
subplot(2,3,3)
hold on
%---------------------------------------------------
%Asymetric steps

a = (1-sqrt(3))/2;
b = (1+sqrt(3))/2;

for walkers = 1:1000
    
for step= 2:trials
    r = randi(3);
    switch r
        case 1
            x(step) = x(step-1)  -1;
        case 2
            x(step) = x(step-1)  + a; 
        case 3
             x(step) = x(step-1)  + b;
     end
       
end
plot(x,y,'color','blue','LineWidth',1)

    x(t) = 200+ round(x(t));
   final_position(x(t)) =  final_position(x(t)) +1;
end
 ylabel('$t$','Interpreter','latex','FontSize',10)
 xlabel('$\Delta x $','Interpreter','latex')
subplot(2,3,6)

bar(final_position,3)
 ylabel('$P(x)$','Interpreter','latex','FontSize',10)
 xlabel('$x + 200 $','Interpreter','latex')

toc

