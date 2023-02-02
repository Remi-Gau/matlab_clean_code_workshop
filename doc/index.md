# Clean code workshop: MATLAB

This workshop aims to show some good coding practices to use with MATLAB or
Octave.

!!! warning

    This workshop is still under development.
    Requirements and content may still be updated in the coming days.

    **Make sure sure to check this page regularly.**

## Requirements

### MATLAB

- It does not need to be recent version.
- Let me know (by
  [opening an issue](https://github.com/Remi-Gau/matlab_clean_code_workshop/issues/new))
  if you need access to a MATLAB license for the duration of the workshop.

#### MATLAB toolboxes

Those 2 MATLAB toolboxes will help with running tests and code coverage:

- [MOxUnit](https://github.com/MOxUnit/MOxUnit)
- [MOcov](https://github.com/MOcov/MOcov)

!!! note

    Recent versions of MATLAB also have their own [testing framework](https://nl.mathworks.com/help/matlab/matlab-unit-test-framework.html). But I will not use it in this workshop.

### GIT

- command line or [GUI](https://git-scm.com/downloads/guis): whatever you
  prefer! 😄
- a [gitlab](https://gitlab.com/) account

### Code editor

Install [VS-code](https://code.visualstudio.com/) as a proper code editor will
be useful when working with files that are not MATLAB scripts or functions.

#### VS-code extensions

VS-code has many extensions. Two that may be useful:

- [MATLAB](https://marketplace.visualstudio.com/items?itemName=Gimly81.matlab)
  allows MATLAB syntax highlighting.
- [error-lens](https://marketplace.visualstudio.com/items?itemName=usernamehw.errorlens)
  highlights errors in the code.

### Python

- For example installed via
  [conda](https://docs.conda.io/en/latest/miniconda.html#system-requirements).

#### Python packages

- [miss_hit](https://misshit.org/download.html) for MATLAB code style checking,
  formatting and linting

```bash
pip install miss_hit
```

- [pre-commit](https://pre-commit.com/#installation) for applying code style
  checks before committing

```bash
pip install pre-commit
```
