% (C) Copyright 2023 Remi Gau developers
%
% script to run the tests with MOxUnit
%
% This script can be run locally or on github CI.
%

current_directory = pwd;

root_dir = getenv('GITHUB_WORKSPACE');
% set up for testing in github CI
if ~isempty(root_dir)
    addpath(fullfile(root_dir, 'MOcov', 'MOcov'));

    cd(fullfile(root_dir, 'MOxUnit', 'MOxUnit'));
    run moxunit_set_path();

    % set up for local testing
else
    root_dir = fullfile(fileparts(mfilename('fullpath')), '..', '..');

end

% run tests for the example function created during the workshop
cd(fullfile(root_dir, 'doc', 'testing'));
run Run_Tests;

% run tests on the legacy code
cd(root_dir);
run Run_Tests_Legacy_Code;
