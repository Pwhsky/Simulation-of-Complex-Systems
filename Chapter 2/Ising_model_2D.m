clear
tic
%Ising model in 2D

lattice = randi([0 1], 200);
lattice(lattice == 0) = -1;

H = -1;
T = 5;
beta = 1/(T);
time_steps = 1e5;

fig = figure;
    
for t = 1:time_steps
    
   for u = 1:4000
       
    i = randi([2 199]);
    j = randi([2 199]);
    M = lattice(i-1,j) + lattice(i+1,j) + lattice(i,j-1) + lattice(i,j+1);
    
    E_plus = -H - M;
    E_minus = H+M;
    
     probability = (exp(-E_minus*beta))/(exp(-E_plus*beta)+exp(-E_minus*beta));
    
    r = rand();

    if r > probability
        if lattice(i,j) == -1
        lattice(i,j) = 1;
        end
    else 
        if lattice(i,j) == 1
        lattice(i,j) = -1;
        end
    end
   

   end
   
switch t
    case 1
        subplot(1,4,1)
        imagesc(lattice)
        title('t = 1')
    case 1e2
        subplot(1,4,2)
        imagesc(lattice)
        title('t = 100')
    case 1e4
        subplot(1,4,3)
        imagesc(lattice)
        title('t = 10000')
    case time_steps
         subplot(1,4,4)
        imagesc(lattice)
        title('t = 100000')
      
end
   

    
    
    
end



han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'T = 5, H = -1');
toc