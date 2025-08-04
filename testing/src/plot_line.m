function handle = plot_line(x, y)
    % Create a PNG file for the line for values x and y.
    %

    % (C) Copyright 2023 Remi Gau

    handle = figure('name', 'line');

    plot(x, y);

    xlabel('x values');
    ylabel('y values');

    print(gcf, 'my_figure.png', '-dpng');

end
