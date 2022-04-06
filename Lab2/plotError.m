function plotError(error,graph_title)
    figure;
    title(graph_title);
    hold on;
    plot(error)
    xlabel('J');
    ylabel('Error');
end
