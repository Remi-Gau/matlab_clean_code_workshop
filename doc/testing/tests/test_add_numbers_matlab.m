function tests = test_add_numbers_matlab
    % (C) Copyright 2023 Remi Gau
    tests = functiontests(localfunctions);
end

function test_add_numbers_basic(testCase)  %#ok<*INUSD>

    a = 1;
    b = 2;

    c = add_numbers(a, b);

    assert(c == 3);

end
