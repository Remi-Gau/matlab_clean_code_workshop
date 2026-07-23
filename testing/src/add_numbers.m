function c = add_numbers(a, b)
    % Add 2 numbers.

    % (C) Copyright 2023 Remi Gau

    if ~isnumeric(a)
        err.message = 'a must a scalar value.';
        err.identifier = 'add_numbers:ScalarExpected';
        error(err);
    end

    c = a + b;
end
