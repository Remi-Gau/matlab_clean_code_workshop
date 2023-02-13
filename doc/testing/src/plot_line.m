function handle = plot_line(x, y)
    % (C) Copyright 2023 Remi Gau
    handle = figure('name', 'line');

    plot(x, y);

    xlabel('x values');
    ylabel('y values');

    print(gcf, 'my_figure.png', '-dpng');

end
