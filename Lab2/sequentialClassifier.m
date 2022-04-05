function [G, n_ab, n_ba] = sequentialClassifier(A,B,J)
    n_ab = {};
    n_ba = {};
    G = {};

    j = 1;
    while true
        while true
            b_as_a_error = [];
            a_as_b_error = [];

            % Select one random point each from A and B.
            if (size(A,1) > 0)
                a_rand = ceil(rand * size(A,1));
                a_mu = A(a_rand,:);
            end
            if (size(B,1) > 0)
                b_rand = ceil(rand * size(B,1));
                b_mu = B(b_rand,:);
            end

            % Classify all points (For class A)
            for i=1:size(A,1)
                x = A(i,:);
                x_class = calculateMED(x(1),x(2),a_mu,b_mu);

                if (x_class == 2) % if classified as class B
                    % Add misclassified point
                    a_as_b_error(end+1,:) = x;
                end
            end

            % Classify all points (for class B)
            for i=1:size(B,1)
                x = B(i,:);
                x_class = calculateMED(x(1),x(2),a_mu,b_mu);

                if (x_class == 1)
                   b_as_a_error(end+1,:) = x;
                end
            end

            n_ab_j = size(a_as_b_error,1);
            n_ba_j = size(b_as_a_error,1);

            % exit loop if there is no misclassified
            if (n_ab_j == 0 || n_ba_j == 0)
               if (n_ab_j == 0)
                   B = b_as_a_error;
               end
               if (n_ba_j == 0)
                   A = a_as_b_error;
               end
               break;
            end
        end

        % Remember the points for that particular discriminant
        G = [G, [a_mu; b_mu]];
        n_ab = [n_ab, n_ab_j];
        n_ba = [n_ba, n_ba_j];

        if (size(A,1) == 0 && size(B,1) == 0)
            break;
        end
        if (J ~= 0 && j >= J)
            break;
        end

        j = j + 1;
    end
end
