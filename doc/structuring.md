# Structuring your project

- Each analysis step is one script
- A script either processes a single recording or aggregates across recordings, never both
- One master script to run the entire analysis
- Save all intermediate results
- Visualize all intermediate results
- Each parameter and file name is defined only once
- Distinguish files that are part of the official pipeline from other scripts


## Filenames

- Avoid white spaces.
- Use only letters, numbers, hyphens, and underscores.
- Don’t rely on letter case.
- Use separators in a meaningful way.

## External libraries

- Ship your code with the libraries it depends on.
- Use a `lib` (or `ext`) folder at the root of your project.

## Data

- Use a systematic filename pattern

For example Brain imaging data structure (BIDS) filename patterns: 

```text
key1-value_key2-value_suffix.extension
```