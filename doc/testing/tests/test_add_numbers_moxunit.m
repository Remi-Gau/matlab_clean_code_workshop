function test_suite = test_add_numbers_moxunit %#ok<STOUT>
    % (C) Copyright 2023 Remi Gau
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_add_numbers_basic()

    a = 1;
    b = 2;

    c = add_numbers(a, b);

    assertEqual(c, 3);

end
