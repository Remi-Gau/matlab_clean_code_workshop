function test_plot_line()
    % (C) Copyright 2023 Remi Gau

    % set up
    % make sure we start from a "clean slate"
    if exist('my_figure.png', 'file')
        delete('my_figure.png');
    end
    close all;

    x = 1:100;
    y = 3 * x + 5 + randn(1, 100) * 10;

    handle = plot_line(x, y);

    assert(strcmp(handle.Name, 'line'));
    assert(exist('my_figure.png', 'file') == 2);

    % teardown
    % remove an file created during the test
    delete('my_figure.png');
    close all;

end
