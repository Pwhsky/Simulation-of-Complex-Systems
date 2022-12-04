%Brownian motion with Phoretic interactions

clear

clf
tic
box_size = 100*1e-6;

D_T = 0.1*1e-6;
D_R = 1;
R = 1e-6;
v = 3e-6;
v_0 = 20*1e-6;
N = 20;
dt = 0.005;
time_steps = 100;
cutoff_distance = 8*R;

%Pre-compute certain constants here:
position_history = zeros(N,2,time_steps);
rotation_constant = sqrt(2*D_R*dt);
translation_constant = 2*D_R*dt;

%Initialize position data for N particles
position_matrix = rand(N,2).*box_size;
phi_matrix = rand(N,1)*2*pi;


xlabel('X [m]','interpreter','latex')
ylabel('Y [m]','interpreter','latex')

on_edge_history = ones(N,2,time_steps);
edge_pos = ones(N,1);

for t = 2:time_steps
    
    for iN = 1:N
    phoretic_velocity = [0 0];
    
       for jN = 1:N 
       phoretic_velocity = phoretic_velocity +...
       phoretic_interaction(v_0,R,position_history(iN,:,t-1),position_history(jN,:,t-1), cutoff_distance);
       
       
       position_matrix(iN,:) = simulate_motion(position_matrix(iN,:),phi_matrix(iN),dt,translation_constant,rotation_constant,v,phoretic_velocity);
        [position_matrix, edge_pos] = check_boundary(position_matrix, N, box_size);
        
        position_matrix = overlap_check(position_matrix, R, N);
        position_history(:, :, t + 1) = position_matrix;
        on_edge_history(:,t+1) = edge_pos;
       
       end
   end
   
end



toc
%% Movie Loop
clf
figure(1)

for t = 1:time_steps
  
   plot(position_history(:,1,t),position_history(:,2,t),'.','markersize',10,'color','k')
     axis manual equal

 xlim([-1 1])
 ylim([-1 1])
   pause(0.04)
 drawnow
end




function new_position = simulate_motion(position,phi,dt,translation_constant,rotation_constant,v,phoretic_velocity)
    new_position = [0 0];
    new_phi = phi + rotation_constant*randn;
    
    new_position(1) = position(1) + v*cos(new_phi)*dt +...
        translation_constant*randn + phoretic_velocity(1)*dt; 
    
    new_position(2) =  position(2) + v*sin(new_phi)*dt +...
        translation_constant*randn + + phoretic_velocity(1)*dt;
end

%New_positions will be a 2x2 matrix for a particle pair

function new_positions = hard_sphere_correction(position_1,position_2,R)
new_positions = zeros(2,2);
distance_to_center = norm(position_1-position_2);
overlap = R*2 - distance_to_center;

if overlap > 0 && overlap ~= R*2
        distance_to_move = overlap / 2;
        direction_to_move = (position_1 - position_2)./distance_to_center;
        
        new_positions(1,:) = position_1 + direction_to_move * distance_to_move;
        new_positions(2,:) = position_2 - direction_to_move * distance_to_move;
       
elseif overlap == R*2
        phi = rand * 2 * pi;
        new_positions(1,:) = position1 + R * [cos(phi) sin(phi)];
        new_positions(2,:) = position2 - R * [cos(phi) sin(phi)];
      
else
        new_positions(1,:) = position_1;
        new_positions(2,:) = position_2;
end

end

function position_matrix = overlap_check(position_matrix,R,N)
for i = 1:N
    for j = 1:N
        if i ~= j
            corrected_positions = hard_sphere_correction(position_matrix(i, :), position_matrix(j, :), R);
            position_matrix(i,:) = corrected_positions(1,:);
            position_matrix(j,:) = corrected_positions(2,:);
        end
    end
end  
end

function [position_matrix, edge_pos] = check_boundary(position_matrix,N,box_size)
edge_pos = ones(N,1);

for i = 1:N
  if position_matrix(i, 1) > box_size
           position_matrix(i, 1) = position_matrix(i, 1) - box_size;
           edge_pos(i) = nan;
           
  elseif position_matrix(i, 1) < 0
            position_matrix(i, 1) = position_matrix(i, 1) + box_size;
            edge_pos(i) = nan;
            
        if position_matrix(i, 2) > box_size
            position_matrix(i, 2) = position_matrix(i, 2) - box_size;
            edge_pos(i) = nan;
        elseif position_matrix(i, 2) < 0
            position_matrix(i, 2) = position_matrix(i, 2) + box_size;
            edge_pos(i) = nan;
        end
  end
        
end

end

function phoretic_velocity = phoretic_interaction(v_0,R,position_1,position_2,cutoff_distance)
distance = norm(position_1-position_2);
    if distance < cutoff_distance && distance ~= 0
    direction = (position_2 - position_1)./distance;
    phoretic_velocity = ((v_0*R^2)/(distance^2))*direction;
    else
    phoretic_velocity = [0 0];
    end

end