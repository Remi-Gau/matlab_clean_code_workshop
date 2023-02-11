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

    group_level();

    close all;
    clear;

end
