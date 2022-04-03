function plotError(error,title)
    figure;
    title(title);
    hold on;
    plot(error);
    xlabel('# of Iteration');
    ylabel('Error');
end
