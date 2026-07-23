function tests = test_create_participant_file_matlab %#ok<STOUT>
    % (C) Copyright 2023 Remi Gau
    tests = functiontests(localfunctions);
end

function test_unit_one(testCase)
    filename = create_participant_file('02', 'rest', 1);

    expected_output = 'sub-02_task-rest_run-1.csv';
    assert(ischar(filename));
    assert(strcmp(filename, expected_output));
end

function test_unit_two(testCase)
    filename = create_participant_file('02', 'faceRepetition', 1);

    expected_output = 'sub-02_task-faceRepetition_run-1.csv';
    assert(ischar(filename));
    assert(strcmp(filename, expected_output));
end
