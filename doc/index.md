# Clean code workshop: MATLAB

This workshop aims to show some good coding practices to use with MATLAB.

Even though the examples rely on MATLAB code,
this contains a lot of very generic rules that are language independent
and that that will work equally well, 
whether you are coding in MATLAB, Octave, Python...

!!! info "Next workshop"

    The next workshop will be: 

    - on the **9th and 10th of February 2021**
  
    - at the **University of Marburg (DSA Sprachatlas, Pilgrimstein, Marburg)**

!!! warning

    This workshop is still under development.
    Requirements and content may still be updated in the coming days.

    **Make sure sure to check this page regularly.**

## Requirements

Please make sure you have the following installed on your computer before the
workshop.

!!! info "Open office"

    If you have issues opening some of the required tools, 
    there will be some "open office hours":

    - Tuesday, February 7th, 3:30pm-5pm, on zoom,
    - on both workshop days:
        - during the hour before the start of the workshop (9am-10am)
        - during lunch time 

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
- a [gitlab](https://gitlab.com/) account (the one from your university is
  probably fine).

To make sure you are set for the workshop, please make sure you can fork this
[repository](https://gitlab.com/Remi-Gau/matlab_clean_code_workshop).

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

## Sample code and data

If you do not come to the workshop with your own code, you can use the sample
code and data provided in this repository - see the folders
`code` 
(on [gitlab](https://gitlab.com/Remi-Gau/matlab_clean_code_workshop/-/tree/main/code) 
or [github](https://github.com/Remi-Gau/matlab_clean_code_workshop/tree/main/code)) 
and `data` 
(on [gitlab](https://gitlab.com/Remi-Gau/matlab_clean_code_workshop/-/tree/main/data) 
or [github](https://github.com/Remi-Gau/matlab_clean_code_workshop/tree/main/data)) .
