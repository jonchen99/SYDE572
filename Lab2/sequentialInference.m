function [class] = sequentialInference(x,y,G,n_ab,n_ba)
    class = 0;
    for j = 1:numel(G)
        a_mu = G{j}(1,:);
        b_mu = G{j}(2,:);

        class = calculateMED(x,y,a_mu,b_mu);
        if (class == 1 && n_ba{j} == 0)
            break;
        end
        if (class == 2 && n_ab{j} == 0)
            break;
        end
    end
end
