clear
tic
N = 16;

forest = zeros(N);
growth_parameter = 0.01;
lightning_chance = 0.2;

%Simulation loop
%0 = empty tile
%1 = tree
%2 = lightning strike
%3 = burned tree
%4 = fire

for time = 0:1e5
   r = rand;
   
   if r < growth_parameter
      forest(randi(16),randi(16)) =1;
   end
    
   r = rand;
   
  lightning_position = [randi(16) randi(16)];       

   
   %Did the lightning hit a tree?
 if forest(lightning_position(1),lightning_position(2)) == 1 && r < lightning_chance
     forest(lightning_position(1),lightning_position(2)) = 4;
     for i = 1:N
         for j = 1:N
             if forest( min(i+1, N-1),j) == 1
                 forest( min(i+1, N-1),j) = 4;
             end
             if forest( max(i-1, 0),j) == 1
                 forest( max(i-1, 0),j) = 4;
             end
             
             if forest( i,min(j+1, N-1)) == 1
                forest( i,min(j+1, N-1)) = 4;
             end
             
             if forest(i, max(j-1, 0)) == 1
                 forest(i, max(j-1, 0)) = 4;
             end
             forest(i,j) = 3;
             
         end
     end
     
     
     
     
 end
   
end

toc