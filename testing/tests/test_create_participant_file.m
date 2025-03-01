function test_suite = test_create_participant_file %#ok<STOUT>
    % (C) Copyright 2023 Remi Gau
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_smoke
    run_numbers = -10:0:10;
    for i = 1:numel(run_numbers)
        create_participant_file('01', 'rest', run_numbers(i));
    end
end

function test_unit_one
    filename = create_participant_file('01', 'rest', 1);

    expected_output = 'sub-01_task-rest_run-1.csv';
    assert(ischar(filename));
    assert(strcmp(filename, expected_output));
end

function test_unit_two
    filename = create_participant_file('02', 'rest', 1);

    expected_output = 'sub-02_task-rest_run-1.csv';
    assert(ischar(filename));
    assert(strcmp(filename, expected_output));
end

function test_unit_three
    filename = create_participant_file('02', 'rest', 2);

    expected_output = 'sub-02_task-rest_run-2.csv';
    assert(ischar(filename));
    assert(strcmp(filename, expected_output));
end

function test_unit_five
    filename = create_participant_file('02', 'rest', 1);

    expected_output = 'sub-02_task-rest_run-1.csv';
    assert(ischar(filename));
    assert(strcmp(filename, expected_output));
end

function test_unit_subject_number_as_number
    filename = create_participant_file(2, 'rest', 2);

    expected_output = 'sub-2_task-rest_run-2.csv';
    assert(strcmp(filename, expected_output));
end
