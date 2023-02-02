% (C) Copyright 2023 Remi Gau developers

curent_directory = pwd;

root_dir = getenv('GITHUB_WORKSPACE');

% set up for github CI
if ~isempty(root_dir)
    addpath(fullfile(root_dir, 'MOcov', 'MOcov'));

    cd(fullfile(root_dir, 'MOxUnit', 'MOxUnit'));
    run moxunit_set_path();

    % set up for local
else
    root_dir = fullfile(fileparts(mfilename('fullpath')), '..', '..');
end

cd(fullfile(root_dir, 'part_1'));
run Run_Tests;

cd(curent_directory);
