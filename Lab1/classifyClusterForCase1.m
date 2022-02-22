function [classifiedCorrectly, classifiedIncorrectly] = classifyClusterForCase1(cluster, mean1, mean2)
    classifiedCorrectly = 0;
    classifiedIncorrectly = 0;
    
    for i = 1:size(cluster,1)
        d1 = sqrt((mean1(1) - cluster(i,1))^2 + (mean1(2) - cluster(i,2))^2);
        d2 = sqrt((mean2(1) - cluster(i,1))^2 + (mean2(2) - cluster(i,2))^2);
        if (d1 < d2)
            classifiedCorrectly = classifiedCorrectly + 1;
        elseif (d2 < d1)
            classifiedIncorrectly = classifiedIncorrectly + 1;
        end
    end
end
