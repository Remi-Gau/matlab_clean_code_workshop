function test_suite = test_analyse %#ok<STOUT>
    % (C) Copyright 2023 Remi Gau developers
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_analyse_basic()

    %% set up
    root_dir = fullfile(fileparts(mfilename('fullpath')), '..');
    data_dir = fullfile(root_dir, 'data');
    subject_dir = fullfile(data_dir, 'sub-01');
    output_figure = fullfile(subject_dir, 'Behavioral', 'Figures.ps');
    output_mat_file = fullfile(subject_dir, 'Behavioral', 'Results_PIEMSI_1.mat');

    if exist(output_mat_file, 'file')
        delete(output_mat_file);
    end
    if exist(output_figure, 'file')
        delete(output_figure);
    end
    close all;

    %% test
    cd(subject_dir);
    Analyse();

    % check created files
    assert(exist(output_figure, 'file') == 2);
    assert(exist(output_mat_file, 'file') == 2);

    % check all values are those exepected
    expected = load(fullfile(subject_dir, ...
                             'Behavioral', ...
                             'expected_results.mat'));
    results = load(fullfile(subject_dir, ...
                            'Behavioral', ...
                            'Results_PIEMSI_1.mat'));
    assertEqual(results, expected);

    %% tear down
    % remove any files created during the test
    delete(output_figure);
    delete(fullfile(subject_dir, 'Behavioral', 'Fig*.eps'));
    close all;

end
