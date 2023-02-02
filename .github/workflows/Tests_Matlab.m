% (C) Copyright 2023 Remi Gau developers

root_dir = getenv('GITHUB_WORKSPACE');

addpath(fullfile(root_dir, 'MOcov', 'MOcov'));

cd(fullfile(root_dir, 'MOxUnit', 'MOxUnit'));
run moxunit_set_path();

cd(fullfile(root_dir, 'part_1'));
run run_tests;
