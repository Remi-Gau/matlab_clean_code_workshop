function c = add_numbers_with_assert(a, b)
    c = a + b;
    assert(numel(c) == 1, 'b must be a scalar')
end
