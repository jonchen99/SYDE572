function [med] = calculateMED(a,b,mean_a,mean_b)
    a_mu = transpose(mean_a);
    b_mu = transpose(mean_b);
    distance_a = (a - a_mu(1))^2 + (b - a_mu(2))^2;
    distance_b = (a - b_mu(1))^2 + (b - b_mu(2))^2;
    
    if (distance_a < distance_b)
    	med = 1;
    else 
        med = 2;
    end
end