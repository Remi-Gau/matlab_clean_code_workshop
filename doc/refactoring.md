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

- [x] Remove and commit.

### Useless comments

- [x] Remove and commit.

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

- [x] Extract function, test and commit.

### Excessive nesting & magic numbers

- [x] Remove the try-catch in `Analyse.m`, test, commit.

- [x] Remove one level of nesting in the main loop of `Analyse.m`,
      by continuing the loop if short reaction time,
      test, commit.

- [x] Create a constant, test and commit.

```matlab
for i=1:NbTrials

	% Skips trials where answer came with impossible reaction time
	% (negative or before the beginning of the movie)
	if TotalTrials{1,1}(i,6)>0.5

		% rest of the code

	end

end
```

```matlab
REACTION_TIME_THRESHOLD_SEC = 0.5;

for i=1:NbTrials

	reaction_time_sec = TotalTrials{1,1}(i,6);
	if reaction_time_sec <= REACTION_TIME_THRESHOLD_SEC
		continue
	end

	% rest of the code

end
```

### Long functions

Split into smaller functions, test and commit.

- [x] create at least one function to simply plot a figure

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
