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

[ ] create a function

<!-- 
```matlab
{% include "src/add_numbers.m" %}
```
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

[ ] use `assert` inside the function to check some aspect 
    of the behavior of the function

<!--
```matlab
{% include "src/add_numbers_with_assert.m" %}
```
-->

## Smoke test

```mermaid
flowchart LR
    subgraph test
        direction LR
        A[some_input] --> B(function)
        B --> C[some_output]
    end
```

[ ] create a "smoke" test by writing a function 
    that calls the function with some input

<!--
```matlab
{% include "tests/test_add_numbers_smoke.m" %}
```
-->

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

[ ] create a unit test by writing a function that calls the function 
    with a specific input and assert that that the output is as expected

<!-- 
```matlab
{% include "tests/test_add_numbers_unit.m" %}
```
-->

[ ] test the function with a variety of inputs

## Using a testing framework

[ ] rewrite the unit test so that it can be run 
    with MOxUnit or MATLAB testing framework

### With MoxUnit

<!--
```matlab
{% include "tests/test_add_numbers_moxunit.m" %}
```

```matlab
success = moxunit_runtests(test_folder, ...
                           '-verbose', ...
                           '-recursive', ...
                           '-cover', source_cover)
```
-->

### With MATLAB

<!--
```matlab
{% include "tests/test_add_numbers_matlab.m" %}
```
-->

## Code coverage

[ ] write a script to use MoxUnit to run all the tests 
    and generate a code coverage report

<!--
```matlab
success = moxunit_runtests(testFolder, ...
                           '-verbose', ...
                           '-recursive', ...
                           '-with_coverage', ...
                           '-cover', folderToCover, ...
                           '-cover_html_dir', fullfile(pwd, 'coverage_html'));
```
-->

## Testing "legacy" code


- [ ] create a new repository and add the `code` and `data` folder in it
- [ ] add tests for the functions in `code`
      The test should check that the data saved by each function
      is "equivalent" to the one already present in the `data` folder.


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