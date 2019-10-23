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
	cd slurm-knitr-spin
	chmod +x spin
	chmod +x knitr_spin.R
	```

3. Add `slurm-knitr-spin` to your path, however you like. For instance in your ~/.bashrc file add:

	```sh
	export PATH=$PATH:/path/to/slurm-knitr-spin/
	```

## Usage


Spin must be used with the following command line arguments `$ spin <my-script.R> <qos> <constraints> <time> <mem (in Gb)>`. See SLURM manual for description of arguments.

Internally, `knitr::spin(<script.R>)` is used to convert `<script.R>` into `<script.md>`, the markdown version of the same script.

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

and `$ spin 1.script.R ...` is called from within subfolder1, the project space will update to:

```
project/
│   README.md    
│
└───subfolder1/
    │   subfolder1.md
    │   1-script.R
    |	1-script/
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
