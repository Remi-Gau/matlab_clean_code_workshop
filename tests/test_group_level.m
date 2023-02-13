function test_suite = test_group_level %#ok<STOUT>
    % (C) Copyright 2023 Remi Gau

    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_group_level_basic()

    root_dir = fullfile(fileparts(mfilename('fullpath')), '..');
    data_dir = fullfile(root_dir, 'data');
    subjects = dir(fullfile(data_dir, 'sub-*'));

    for i = 1:numel(subjects)
        copyfile(fullfile(data_dir, subjects(i).name, 'Behavioral', 'Results*.mat'), ...
                 data_dir);
    end

    cd(data_dir);

    cfg.verbose = true;
    cfg.position = [50 50 2000 1000];

    group_level(cfg);

    expected = load(fullfile(data_dir, 'expected_results.mat'));
    results = load(fullfile(data_dir, 'Group_Results.mat'));

    % test
    expected_fields = fieldnames(expected);
    for i = 1:numel(expected_fields)
        assert(isfield(results, expected_fields{i}), ...
               sprintf('missing %s', expected_fields{i}));
        assertEqual(results.(expected_fields{i}), expected.(expected_fields{i}));
    end

    close all;
    clear;

end
