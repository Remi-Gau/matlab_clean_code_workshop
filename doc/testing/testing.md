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
<!-- 
```matlab
{% include "tests/test_add_numbers_unit.m" %}
```
-->

## Using a testing framework

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