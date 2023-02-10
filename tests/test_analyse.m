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
    cfg.verbose = true;
    cfg.position = [50 50 1000 1000];

    analyse(cfg);

    expected = load(fullfile(subject_dir, 'Behavioral', 'expected_results.mat'));
    results = load(fullfile(subject_dir, 'Behavioral', 'Results_PIEMSI_1.mat'));

    assertEqual(results, expected);

    % tear down
    delete(fullfile(subject_dir, 'Behavioral', '*.eps'));
    delete(fullfile(subject_dir, 'Behavioral', 'Results_PIEMSI_1.mat'));
end
