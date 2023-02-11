function test_suite = test_analyse %#ok<STOUT>
    % (C) Copyright 2023 Remi Gau

    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_analyse_basic()

    root_dir = fullfile(fileparts(mfilename('fullpath')), '..');
    data_dir = fullfile(root_dir, 'data');
    subject_dir = fullfile(data_dir, 'sub-01');

    cd(subject_dir);

    cfg.reaction_time_threshold = 0.5;
    cfg.verbose = false;
    cfg.position = [50 50 1000 1000];
    cfg.missed_response_value = 999;

    analyse(cfg);

    expected = load(fullfile(subject_dir, 'Behavioral', 'expected_results.mat'));
    results = load(fullfile(subject_dir, 'Behavioral', 'Results_PIEMSI_1.mat'));

    expected_fields = fieldnames(expected);
    for i = 1:numel(expected_fields)
        assert(isfield(results, expected_fields{i}), ...
               sprintf('missing %s', expected_fields{i}));
    end
    actual_fields = fieldnames(results);
    for i = 1:numel(actual_fields)
        assert(isfield(expected, actual_fields{i}), ...
               sprintf('missing %s', actual_fields{i}));
    end

    assertEqual(results.(expected_fields{i}), results.(expected_fields{i}));

    % tear down
    delete(fullfile(subject_dir, 'Behavioral', '*.eps'));
    delete(fullfile(subject_dir, 'Behavioral', 'Results_PIEMSI_1.mat'));

    close all;
    clear;

end
