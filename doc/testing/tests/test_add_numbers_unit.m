function test_add_numbers_smoke()
    % (C) Copyright 2023 Remi Gau

    a = 1;
    b = 2;

    c = add_numbers(a, b);

    assert(c == 3);

end
