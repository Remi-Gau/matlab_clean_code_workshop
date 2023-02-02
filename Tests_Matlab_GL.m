% (C) Copyright 2023 Remi Gau developers

% script to run the tests in gitlab CI with MOxUnit

current_directory = pwd;

disp(curent_directory);

root_dir = current_directory;

disp(root_dir);

disp(ls);

% set up for github CI
if ~isempty(root_dir)
    addpath(fullfile(root_dir, 'MOcov', 'MOcov'));

    cd(fullfile(root_dir, 'MOxUnit', 'MOxUnit'));
    run moxunit_set_path();

    % set up for local
else
    root_dir = fullfile(fileparts(mfilename('fullpath')), '..', '..');
end

cd(fullfile(root_dir, 'doc', 'part_1'));
run Run_Tests;

cd(current_directory);
