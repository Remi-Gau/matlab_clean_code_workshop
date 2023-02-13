# Testing

<!--
!!! quote ""

    Untested code is broken code.
-->

``` mermaid
graph LR
    A[input] --> B(function)
    B --> C[output]
```

- [x] create a function

```matlab
{% include "testing/src/add_numbers.m" %}
```

<!--
Code without tests is code that you are afraid to change.

Code without tests is code with undefined behavior.
-->

## Using `assert`

<!--
!!! quote ""

    Some testing is better then no testing
-->

```mermaid
graph LR
    A[input] --> B(function)
    B --> C[output]
    C --> D(assert)
```

- [x] use `assert` inside the function to check some aspect
      of the behavior of the function

```matlab
{% include "testing/src/add_numbers_with_assert.m" %}
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

- [x] create a "smoke" test by writing a function that:
    - [x] calls the function with some input

```matlab
{% include "testing/tests/test_add_numbers_smoke.m" %}
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

- [x] create a unit test by writing a function that:
    - [x] calls the function with a specific input
    - [x] asserts that that the output is as expected

```matlab
{% include "testing/tests/test_add_numbers_unit.m" %}
```

- [x] test the function with a variety of inputs

### Other example

#### `plot_line`

```matlab
{% include "testing/src/plot_line.m" %}
```

```matlab
{% include "testing/tests/test_plot_line.m" %}
```

## Using a testing framework

- [x] rewrite the unit test so that it can be run
      with MOxUnit or MATLAB testing framework

### With MoxUnit

```matlab
{% include "testing/tests/test_add_numbers_moxunit.m" %}
```

```matlab
success = moxunit_runtests(test_folder, ...
                           '-verbose', ...
                           '-recursive', ...
                           '-cover', source_cover)
```

### Other example

#### `create_participant_file`

```matlab
{% include "testing/src/create_participant_file.m" %}
```

```matlab
{% include "testing/tests/test_create_participant_file.m" %}
```

### With MATLAB

```matlab
{% include "testing/tests/test_add_numbers_matlab.m" %}
```

## Code coverage

- [x] write a script to use MoxUnit to run all the tests
      and generate a code coverage report

```matlab
{% include "testing/Run_Tests.m" %}
```

## Testing "legacy" code

- [x] create a new repository and add the `code` and `data` folder in it
- [x] add tests that should check that the functions in `code` :
    - [x] create figures
    - [x] save data that is "equivalent" to the one already present in the `data` folder,

```matlab
{% include "../tests/test_analyse.m" %}
```

- [x] get a code coverage report for the tests

```matlab
{% include "../Run_Tests_Legacy_Code.m" %}
```


<!--
## F.I.R.S.T.

Test should be:

- Fast
- Independent
- Repeatable
- Self-validating
- Timely
-->

## References

See the [references](../references.md#testing-and-refactoring) page for more information.
