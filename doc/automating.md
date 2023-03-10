# Automating


## Pre-commit

!!! Note

    Only commit clean code.

```bash
pip install pre-commit
```

- [x] add `.pre-commit-config.yaml` to your repository
- [x] add basic "hooks"
- [x] add hooks for miss_hit
- [x] run on all files
- [x] commit

```yaml
{% include "../.pre-commit-config.yaml" %}
```

## CI/CD in github

- [x] create a github repository
- [x] push your code to github
- [x] create a workflow to
    - [x] checkout your repository
    - [x] install miss_hit
    - [x] run miss_hit on your code

```yaml
{% include "../.github/workflows/style.yml" %}
```

## Pre-commit-CI

!!! warning

    Only works on github repositories.

## Running tests in github

- [x] create a workflow to
    - [x] checkout your repository
    - [x] install MoxUnit and MoCov
    - [x] install Matlab
    - [x] run your tests

This workflow is in `.github/workflows/tests.yml`.

```yaml
{% include "../.github/workflows/tests.yml" %}
```

It calls the MATLAB script `.github/workflows/Tests_Matlab.m`.

```matlab
{% include "../.github/workflows/Tests_Matlab.m" %}
```

## CI/CD in gitlab

### Setting up a CI/CD pipeline

```yaml
{% include "../.gitlab-ci.yml" %}
```

<!--
!!! tip

    Create scripts that you can run locally and in CI.
-->
