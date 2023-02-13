# Refactoring

<!-- !!! quote "When to refactor"

    [Rule of Three](https://refactoring.guru/refactoring/when)

    - When you’re doing something for the first time, just get it done.
    - When you’re doing something similar for the second time,
      cringe at having to repeat but do the same thing anyway.
    - When you’re doing something for the third time, start refactoring.
-->

## "code smells"

### Commented code, dead code

- [ ] Remove and commit.

### Useless comments

- [ ] Remove and commit.

### Express yourself in code rather than comments

<!-- !!! quote "Martin Fowler"

    Comments are a failure.
    We must have them because we cannot always figure out how to express ourselves without them,
    but their use is not a cause for celebration.

!!! quote "Tim Ottinger"

    - Comments are for things that cannot be expressed in code.
    - Comments which restate code must be deleted.
    - If the comment says what the code could say,
      then the code must change to make the comment redundant. -->

### Duplication

- [ ] Extract function, test and commit.

### Excessive nesting

- [ ] Remove the try-catch in `Analyse.m`, test, commit.

- [ ] Remove one level of nesting in the main loop of `Analyse.m`,
      by continuing the loop if short reaction time,
      test, commit.

### Magic numbers

- [ ] Create a constant, test and commit.

### Long functions

Split into smaller functions, test and commit.

- [ ] create at least one function to simply plot a figure

## Code Metrics `mh_metric`

miss_hit can help you identify "code smells":

- long files
- complex functions
- too many nesting levels
- too many parameters in a function

```bash
mh_metric --ci
```

<!--
- Use English for code and comments
- Avoid single letter variable names
-->
