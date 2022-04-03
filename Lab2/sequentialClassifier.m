function [discriminants, true_n_ab, true_n_ba] = sequentialClassifier(A,B,J)
    true_n_ab = {};
    true_n_ba = {};
    j = 1;
    discriminants = {};
    while true 
        while true 
            n_ba = 0;
            n_ab = 0;
            temp_a = [];
            temp_b = [];
            classA = zeros(size(A,1),1);
            classB = zeros(size(B,1),1);

            % Get random points from A and B        
            if (size(A,1) > 0)
                a_rand = ceil(rand * size(A,1)); % Randomly select element 1 of row from class A
                a_mu = A(a_rand,:); % Set mean for class A as random row
            end
            if (size(B,1) > 0)
                b_rand = ceil(rand * size(B,1)); % Randomly select element 1 of row from class B
                b_mu = B(b_rand,:); % Set mean for class B as random row
            end

            % Classify all points (For class A)
            for i=1:size(A,1)
                x = A(i,:);  
                classA(i) = calculateMED(x(1),x(2),a_mu,b_mu);

                % Misclassified 
                if (classA(i) == 2)
                    n_ab = n_ab + 1; % Increment error count
                    temp_a(end+1,:) = x; % Add misclassified point
                end
            end

            % Classify all points (For class B)
            for i=1:size(B,1)
                x = B(i,:);  
                classB(i) = calculateMED(x(1),x(2),a_mu,b_mu);

                % Misclassified 
                if (classB(i) == 1)
                   n_ba = n_ba + 1; % Increment error count
                   temp_b(end+1,:) = x; % Add misclassified point
                end
            end
            
            % End if there is no misclassified class
            if (n_ab == 0 || n_ba == 0)
               % Remove correct points if n_ab or n_ba == 0
               if (n_ab == 0)
                   B = temp_b; 
               end
               if (n_ba == 0)
                   A = temp_a; 
               end
               break; 
            end
        end      
    
        discriminants = [discriminants, [a_mu; b_mu]];
        true_n_ab = [true_n_ab, n_ab];
        true_n_ba = [true_n_ba, n_ba];              
        
        if (size(A,1) == 0 && size(B,1) == 0) 
            break;
        end
        % Part 1 - J goes to Infinity (Not J = 5) 
        if (J ~= 0)
            % do nothing 
        end
        if (J ~= 0 && j > J)
        % if it reaches the J (number of discriminants) value, stop
            break;
        end

        % Increment j 
        j = j + 1;    
    end
end