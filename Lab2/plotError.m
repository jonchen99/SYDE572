function plotError(error,graph_title)
    figure;
    title(graph_title);
    hold on;
    plot(error)
    xlabel('Iteration');
    ylabel('Error');
end
