function [ class ] = ml2(al, bl, cl)
    class = zeros(size(al, 1), size(al, 2));

    for i = 1:size(al, 1)
        for j = 1:size(al, 2)
            if (al(i,j) > bl(i,j) && al(i,j) > cl(i,j))
                class(i, j) = 1;
            elseif (bl(i,j) > al(i,j) && bl(i,j) > cl(i,j))
                class(i, j) = 2;
            elseif (cl(i,j) > al(i,j) && cl(i,j) > bl(i,j))
                class(i, j) = 3;
            end
        end
    end
end