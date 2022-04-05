function [class] = classifyClasses(J,X,Y,discriminants,true_n_ab,true_n_ba)
    class = 0;
    while (J < numel(discriminants))
        a_mu = discriminants{J}(1,:);
        b_mu = discriminants{J}(2,:);

        class = calculateMED(X,Y,a_mu,b_mu);
        if (class == 1 && true_n_ba{J} == 0)
            break;
        end
        if (class == 2 && true_n_ab{J} == 0)
            break;
        end
        J = J + 1;
    end
end
