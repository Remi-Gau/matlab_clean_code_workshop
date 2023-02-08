function test_suite = test_Analyse %#ok<STOUT>
    % (C) Copyright 2023 Remi Gau developers
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_Analyse_basic()

    root_dir = '/home/remi/github/matlab_clean_code_workshop/';
    data_dir = fullfile(root_dir, 'data');
    subject_dir = fullfile(data_dir, 'sub-01');

    cd(subject_dir);
    Analyse();

    old_data = load(fullfile(subject_dir, 'Behavioral', 'Results_PIEMSI_1.mat'));
    new_data = load(fullfile(subject_dir, 'Behavioral', 'Results_PIEMSI_1.mat'));

    assertEqual(old_data.NbValidTrials, new_data.NbValidTrials);
    assertEqual(old_data.NbMcGURKinCON, new_data.NbMcGURKinCON);

end
