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

    cfg.reaction_time_threshold = 0.5;
    cfg.verbose = false;
    cfg.position = [50 50 2000 1000];
    cfg.missed_response_value = 999;

    analyse(subject_dir, cfg);

    expected = load(fullfile(subject_dir, 'Behavioral', 'expected_results.mat'));
    results = load(fullfile(subject_dir, 'Behavioral', 'Results_PIEMSI_1.mat'));

    % test
    expected_fields = fieldnames(expected);
    for i = 1:numel(expected_fields)
        assert(isfield(results, expected_fields{i}), ...
               sprintf('missing %s', expected_fields{i}));
        assertEqual(results.(expected_fields{i}), expected.(expected_fields{i}));
    end

    % tear down
    delete(fullfile(subject_dir, 'Behavioral', '*.eps'));

    close all;
    clear;

end
