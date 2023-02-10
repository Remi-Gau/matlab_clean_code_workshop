function c = add_numbers_with_assert(a, b)
    % (C) Copyright 2023 Remi Gau

    c = a + b;
    assert(numel(c) == 1, 'b must be a scalar');
end
