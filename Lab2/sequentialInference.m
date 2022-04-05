function [class] = sequentialInference(X,Y,discriminants,true_n_ab,true_n_ba)
    class = 0;
    for j = 1:numel(discriminants)
        a_mu = discriminants{j}(1,:);
        b_mu = discriminants{j}(2,:);

        class = calculateMED(X,Y,a_mu,b_mu);
        if (class == 1 && true_n_ba{j} == 0)
            break;
        end
        if (class == 2 && true_n_ab{j} == 0)
            break;
        end
    end
end
