# Testing

!!! quote ""
    
    Untested code is broken code.


``` mermaid
graph LR
    A[input] --> B(function)
    B --> C[output]
```

```matlab
{% include "src/add_numbers.m" %}
```

## Using `assert`

!!! quote ""
    
    Some testing is better then no testing

```mermaid
graph LR
    A[input] --> B(function)
    B --> C[output]
    C --> D(assert)
```

```matlab
{% include "src/add_numbers_with_assert.m" %}
```

## Smoke test

```mermaid
flowchart LR
    subgraph test
        direction LR
        A[some_input] --> B(function)
        B --> C[some_output]
    end
```

```matlab
{% include "tests/test_add_numbers_smoke.m" %}
```

## Unit test


```mermaid
flowchart LR
    subgraph test
        direction LR
        A[known_input] --> B(function)
        B --> C[output]
        C --> E(assertEqual)
        D[expected_output] --> E
    end
```

```matlab
{% include "tests/test_add_numbers_unit.m" %}
```

## Using a testing framework

## Code coverage

## Adding test to your code

## References

See the [references](../references.md#testing-and-refactoring) page for more information.