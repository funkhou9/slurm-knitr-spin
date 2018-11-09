# slurm-knitr-spin

> Tool to automatically create a SLURM submission script to spin an R script.
> Relies on the [knitr](https://github.com/yihui/knitr) package developed by Yihui Xie.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)

## Installation

To install, execute the following steps from the remote server:

1. Cone this repository

    ```sh
    git clone https://github.com/funkhou9/slurm-knitr-spin
    ```

2. cd into `slurm-knitr-spin` and ensure both `spin` and `knitr_spin.R` are executable

	```sh
	cd spin-my-script
	chmod +x spin
	chmod +x knitr_spin.R
	```

3. Add `slurm-knitr-spin` to your path, however you like. For instance in your ~/.bashrc file add:

	```sh
	export PATH=$PATH:/path/to/slurm-knitr-spin/
	```

## Usage


Using `$ spin <script.R> intel14 00:10:00 8` will submit `<script.R>` to the `intel18` cluster with a walltime of `10 minutes` and `8GB` of RAM. You must specify those four arguments: cluster, walltime, RAM.

Internally, `knitr::spin(<script.R>)` is used to convert `<script.R>` into `<script.md>`, the *literate* version of the same script.

Additionally your project space will be updated. Assuming your project space looks something like this:

```
project/
│   README.md    
│
└───subfolder1
    │   subfolder1.md
    │   1-script.R
    │
    └───subfolder2
    │   subfolder2.md
    │   1-script.R
    ...
```

and `$ spin project/subfolder1/1-script.R intel14 00:10:00 8` is called, the project space will update to:

```
project/
│   README.md    
│
└───subfolder1/
    │   subfolder1.md
    │   1-script.R
    |	1-script_literate/
    |	|
    |	└─ 1-script.md
    |      1-script.out
    |	   figure/
    │
    └───subfolder2/
    │   subfolder2.md
    │   1-script.R
    ...
```


`1-script.out` contains standard output from the cluster run, which may contain useful information
like walltime used, RAM used, etc. `figure/` is a directory produced by the knitr package, which contains
all figures generated from `1-script.R`
