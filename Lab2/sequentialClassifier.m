function [discriminants, true_n_ab, true_n_ba] = sequentialClassifier(A,B,J)
    true_n_ab = {};
    true_n_ba = {};
    j = 1;
    discriminants = {};

    while true
        while true
            b_as_a_error = 0;
            a_as_b_error = 0;
            temp_a = [];
            temp_b = [];
            classA = zeros(size(A,1),1);
            classB = zeros(size(B,1),1);

            if (size(A,1) > 0)
                a_rand = ceil(rand * size(A,1)); % select the first element of the random row
                a_mu = A(a_rand,:);
            end
            if (size(B,1) > 0)
                b_rand = ceil(rand * size(B,1)); % select the first element of the random row
                b_mu = B(b_rand,:);
            end

            % Classify all points (For class A)
            for i=1:size(A,1)
                x = A(i,:);
                classA(i) = calculateMED(x(1),x(2),a_mu,b_mu);

                if (classA(i) == 2) % if classified as class B
                    % Add to error count
                    a_as_b_error = a_as_b_error + 1;
                    % Add misclassified point
                    temp_a(end+1,:) = x;
                end
            end

            % Class B Classifier
            for i=1:size(B,1)
                x = B(i,:);
                classB(i) = calculateMED(x(1),x(2),a_mu,b_mu);

                if (classB(i) == 1)
                   b_as_a_error = b_as_a_error + 1;
                   temp_b(end+1,:) = x;
                end
            end

            % exit loop if there is no misclassified
            if (a_as_b_error == 0 || b_as_a_error == 0)
               if (a_as_b_error == 0)
                   B = temp_b;
               end
               if (b_as_a_error == 0)
                   A = temp_a;
               end
               break;
            end
        end

        % Remember the points for that particular discriminant
        discriminants = [discriminants, [a_mu; b_mu]];
        true_n_ab = [true_n_ab, a_as_b_error];
        true_n_ba = [true_n_ba, b_as_a_error];

        if (size(A,1) == 0 && size(B,1) == 0)
            break;
        end
        if (J ~= 0)
            % do nothing
        end
        if (J ~= 0 && j >= J)
            break;
        end

        j = j + 1;
    end
end
