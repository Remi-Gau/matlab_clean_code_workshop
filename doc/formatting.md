# Formatting

## Style guide

 - indent your code
 - line length
 - spacing between operators
 - add trailing semicolon
 - remove trailing whitespaces
 - no more than one consecutive empty line

## Use a formatter

### MISS HIT

MATLAB Independent, Small & Safe, High Integrity Tools

```bash
pip install miss_hit
```

#### Style Checker `mh_style`

```bash
mh_style
```

```bash
mh_style --fix
```

- [x] auto-fix all the style errors
- [x] commit

#### Linter `mh_lint`

```bash
mh_lint
```

- [x] fid all the linting errors
- [x] commit

#### Adapt miss_hit configuration

- [x] adapt configuration till you do not get any errors
    - adapt line length
    - adapt copyright
    - ...

- [x] commit
