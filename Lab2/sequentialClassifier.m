function [discriminants, true_n_ab, true_n_ba] = sequentialClassifier(A,B,J)
    discriminants = {};
    true_n_ab = {};
    true_n_ba = {};
    j = 1;
    while true 
        while true 
            error_b_as_a = 0;
            error_a_as_b = 0;
            temp_a = [];
            temp_b = [];
            classA = zeros(size(A,1),1);
            classB = zeros(size(B,1),1);

            if (size(A,1) > 0)
                % Randomly select element 1 from class A
                a_rand = ceil(rand * size(A,1));
                % Set mean
                a_mu = A(a_rand,:); 
            end
            if (size(B,1) > 0)
                b_rand = ceil(rand * size(B,1));
                b_mu = B(b_rand,:);
            end

            % Class A Classification
            for i=1:size(A,1)
                x = A(i,:);  
                classA(i) = calculateMED(x(1),x(2),a_mu,b_mu);
                % if classified as class B
                if (classA(i) == 2)
                    error_a_as_b = error_a_as_b + 1;
                    temp_a(end+1,:) = x;
                end
            end

            % Class B Classification
            for i=1:size(B,1)
                x = B(i,:);  
                classB(i) = calculateMED(x(1),x(2),a_mu,b_mu);
                % if classified as class A
                if (classB(i) == 1)
                   error_b_as_a = error_b_as_a + 1; % Increment error count
                   temp_b(end+1,:) = x; % Add misclassified point
                end
            end
            
            % End if no misclassified 
            if (error_a_as_b == 0 || error_b_as_a == 0)
               % Remove correct points if error_a_as_b or n_ba == 0
               if (error_b_as_a == 0)
                   B = temp_b; 
               end
               if (error_b_as_a == 0)
                   A = temp_a; 
               end
               break; 
            end
        end      
    
        % Remember the points for that particular discriminant  
        discriminants = [discriminants, [a_mu; b_mu]];
        true_n_ab = [true_n_ab, error_a_as_b];
        true_n_ba = [true_n_ba, error_b_as_a];              
        
        % Part 1 - J goes to Infinity (Not J = 5) 
        if (J ~= 0)
            % do nothing 
        end
        if (J ~= 0 && j > J) % J reached the final user-inputted threshold (5)
            break;
        end

        % If length of A or B is zero, break
        if (size(A,1) == 0 && size(B,1) == 0) 
            break;
        end

        % Increment j 
        j = j + 1;    
    end
end