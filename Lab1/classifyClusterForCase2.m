function [classified1, classified2, classified3] = classifyClusterForCase2(cluster, mean1, mean2, mean3)
    classified1 = 0;
    classified2 = 0;
    classified3 = 0;
    
    for i = 1:size(cluster,1)
        d1 = sqrt((mean1(1) - cluster(i,1))^2 + (mean1(2) - cluster(i,2))^2);
        d2 = sqrt((mean2(1) - cluster(i,1))^2 + (mean2(2) - cluster(i,2))^2);
        d3 = sqrt((mean3(1) - cluster(i,1))^2 + (mean3(2) - cluster(i,2))^2);

        if (d1 < d2 && d1 < d3)
            classified1 = classified1 + 1;
        elseif (d2 < d1 && d2 < d3)
            classified2 = classified2 + 1;
        elseif (d3 < d1 && d3 < d2)
            classified3 = classified3 + 1;
        end
    end
end
