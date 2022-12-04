
clear
tic
%Kramer transitions, 3 states: 2 ground states on either side of a barrier.


%constants

k_b = 1.380649*10e-23;
T = 300;
E_b = 2*k_b*T;

probability_ground_state = 1/((exp(-E_b/(k_b*T))) + 1);

probability_excited_state = (exp(-E_b/(k_b*T)))/((exp(-E_b/(k_b*T))) + 2);

time_steps = 1e5;

current_position = zeros(1,3);
position_data = zeros(1,3);

current_position(1) = 1;
hold on
for t = 1:time_steps %Time steps loop
    for i = 1:3
       if current_position(i) ~= 0
           
           %Record data
           position_data(i) =  position_data(i) +1;
           position_trajectory(t) = i;
           
           %Update position
           r = rand;
           if i == 1 || i == 3
              if r > probability_ground_state
                  current_position = [0 1 0]; 
                  break
              end
       
           
           else %the ground states have an equal chance of being selected, on top of not moving
               if r < probability_excited_state                   
                   current_position = [0 1 0];
                   break
               else 
                   flip = rand;
                  if flip < 0.5
                      current_position = [1 0 0];
                      break
                  else
                      current_position = [0 0 1];
                      break
                  end   
               end
           end
           
       end 
    end
end

position_data = position_data./time_steps;
figure(1)
scatter(1:t,position_trajectory*0.01,2)
xlabel('No. of trials')
ylabel('Position')
toc

