# Structuring your project

!!! quote "Seven quick tips for analysis scripts in neuroimaging"

    - Each analysis step is one script
    - A script either processes a single recording or aggregates across recordings, never both
    - One master script to run the entire analysis
    - Save all intermediate results
    - Visualize all intermediate results
    - Each parameter and file name is defined only once
    - Distinguish files that are part of the official pipeline from other scripts

    [source](https://users.aalto.fi/~vanvlm1/papers/van_vliet_2020b.pdf)

## Filenames

- Avoid white spaces.
- Use only letters, numbers, hyphens, and underscores.
- Don’t rely on letter case.
- Use separators in a meaningful way.

## File formats

Save to `.csv`, `.tsv` as much as possible:

- no `.xlsx` file
- no `.mat` file

## External libraries

- Ship your code with the libraries it depends on.
- Use a `lib` (or `ext`) folder at the root of your project.
- Minimize permanent entries to the MATLAB path.

## Use project templates

See the [references](references.md#templates) page for more information.

## Data

- Use a systematic filename pattern

For example the Brain imaging data structure (BIDS) filename patterns:

```text
key1-value_key2-value_suffix.extension
```

- [bids-matlab](https://github.com/bids-standard/bids-matlab) can help you create those filenames
