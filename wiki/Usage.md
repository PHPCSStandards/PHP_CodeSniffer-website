## Table of contents

<!-- START doctoc -->
<!-- END doctoc -->

***

## Getting Help from the Command Line

Running PHP_CodeSniffer with the `-h` or `--help` command line arguments will print a list of commands that PHP_CodeSniffer will respond to. The output of `phpcs -h` is shown below.

```text
{{COMMAND-OUTPUT "phpcs --report-width=110 --no-colors -h"}}
```

> [!NOTE]
> The `--standard` command line argument is optional, even if you have more than one coding standard installed. If no coding standard is specified, PHP_CodeSniffer will default to checking against the _PSR12_ coding standard, or the standard you have set as the default. [View instructions for setting the default coding standard](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki/Configuration-Options#setting-the-default-coding-standard).

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Checking Files and Folders

The most straight-forward way of using PHP_CodeSniffer is to provide the location of a file or folder for PHP_CodeSniffer to check. If a folder is provided, PHP_CodeSniffer will check all files it finds in that folder and all its sub-folders. If you do not want sub-folders checked, use the `-l` command line argument to force PHP_CodeSniffer to run locally in the folders specified.

In the example below, the first command tells PHP_CodeSniffer to check the `myfile.inc` file for coding standard errors while the second command tells PHP_CodeSniffer to check all PHP files in the `my_dir` directory.

```bash
$ phpcs /path/to/code/myfile.inc
$ phpcs /path/to/code/my_dir
```

You can also specify multiple files and folders to check. The command below tells PHP_CodeSniffer to check the `myfile.inc` file and all files in the `my_dir` directory.

```bash
$ phpcs /path/to/code/myfile.inc /path/to/code/my_dir
```

After PHP_CodeSniffer has finished processing your files, you will get an error report. The report lists both errors and warnings for all files that violated the coding standard. The output looks like this:

```bash
$ phpcs path/to/code/fileA.php
{{COMMAND-OUTPUT "phpcs --parallel=1 --no-cache --no-colors --report-width=100 --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php"}}
```

If you don't want warnings included in the output, specify the `-n` command line argument.

```bash
$ phpcs -n path/to/code/fileA.php
{{COMMAND-OUTPUT "phpcs -n --parallel=1 --no-cache --no-colors --report-width=100 --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php"}}
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing a Summary Report

By default, PHP_CodeSniffer will print a complete list of all errors and warnings it finds. This list can become quite long, especially when checking a large number of files at once. To print a summary report that only shows the number of errors and warnings for each file, use the `--report=summary` command line argument. The output will look like this:

```bash
$ phpcs --report=summary /path/to/code
{{COMMAND-OUTPUT "phpcs --parallel=1 --no-cache --no-colors --report-width=100 --report=summary --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code"}}
```

As with the full report, you can suppress the printing of warnings with the `-n` command line argument.

```bash
$ phpcs -n --report=summary /path/to/code
{{COMMAND-OUTPUT "phpcs -n --parallel=1 --no-cache --no-colors --report-width=100 --report=summary --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code"}}
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing Progress Information

By default, PHP_CodeSniffer will run quietly, only printing the report of errors and warnings at the end. If you are checking a large number of files, you may have to wait a while to see the report. If you want to know what is happening, you can turn on progress or verbose output.

To enable progress reporting, use the `-p` command line argument.
With progress output enabled, PHP_CodeSniffer will print a single-character status for each file being checked, like so:

```bash
$ phpcs /path/to/project -p

...S........W.........S.....................................  60 / 110 (54%)
..........EEEE.E.E.E.E.E.E.E.E..W..EEE.E.E.E.EE.E.           110 / 110 (100%)
```

Legend for the progress indicators:

| When scanning with | Indicator    | Means:                                                    |
| ------------------ | ------------ | --------------------------------------------------------- |
| `phpcs`            | `E` (red)    | Non-fixable error(s) found in the file                    |
|                    | `E` (green)  | Fixable error(s) found in the file                        |
|                    | `W` (yellow) | Non-fixable warning(s) found in the file, but no errors   |
|                    | `W` (green)  | Fixable warning(s) found in the file, but no errors       |
| `phpcbf`           | `F` (green)  | Fixed errors and/or warnings in the file                  |
|                    | `E` (red)    | Unfixable errors or warnings in the file (fixer conflict) |
| `phpcs`/`phpcbf`   | `.`          | No errors or warnings found in the file                   |
|                    | `S`          | File was skipped                                          |

> [!NOTE]
> You can configure PHP_CodeSniffer to show progress information by default using [the `show_progress` configuration option](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki/Configuration-Options#showing-progress-by-default)</link>.

With verbose output enabled, PHP_CodeSniffer will print the file that it is checking, show you how many tokens and lines the file contains, and let you know how long it took to process. The output will look like this:

<!--
Regenerate the below output snippet by running the following command from the PHP_CodeSniffer project root directory:
$ phpcs ./src/Standards/Generic/Sniffs/ --standard=PSR12 --no-cache --extensions=php --report=summary -v
-->
```bash
$ phpcs /path/to/project -v

Registering sniffs in the PSR12 standard... DONE (60 sniffs registered)
Creating file list... DONE (79 files in queue)
Changing into directory src/Standards/Generic/Sniffs/Arrays
Processing ArrayIndentSniff.php [1409 tokens in 193 lines]... DONE in 45ms (10 errors, 0 warnings)
Processing DisallowLongArraySyntaxSniff.php [405 tokens in 72 lines]... DONE in 13ms (8 errors, 0 warnings)
Processing DisallowShortArraySyntaxSniff.php [331 tokens in 61 lines]... DONE in 10ms (8 errors, 0 warnings)
Changing into directory src/Standards/Generic/Sniffs/Classes
Processing DuplicateClassNameSniff.php [800 tokens in 118 lines]... DONE in 25ms (13 errors, 1 warnings)
Processing OpeningBraceSameLineSniff.php [936 tokens in 123 lines]... DONE in 29ms (12 errors, 1 warnings)
...
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Specifying a Coding Standard

PHP_CodeSniffer can have multiple coding standards installed to allow a single installation to be used with multiple projects. When checking PHP code, PHP_CodeSniffer can be told which coding standard to use. This is done using the `--standard` command line argument.

The example below checks the `myfile.inc` file for violations against the _PSR12_ coding standard (installed by default).

```bash
$ phpcs --standard=PSR12 /path/to/code/myfile.inc
```

You can also tell PHP_CodeSniffer to use an external standard by specifying the full path to the standard's root directory on the command line. An external standard is one that is stored outside of PHP_CodeSniffer's `Standards` directory.

```bash
$ phpcs --standard=/path/to/MyStandard /path/to/code/myfile.inc
```

Multiple coding standards can be checked at the same time by passing a list of comma separated standards on the command line. A mix of external and installed coding standards can be passed if required.

```bash
$ phpcs --standard=PSR12,Squiz,/path/to/MyStandard /path/to/code/myfile.inc
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing a List of Installed Coding Standards

PHP_CodeSniffer can print you a list of the coding standards that are installed so that you can correctly specify a coding standard to use for testing. You can print this list by specifying the `-i` command line argument.

```bash
$ phpcs -i
{{COMMAND-OUTPUT "phpcs -i"}}
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Listing Sniffs Inside a Coding Standard

PHP_CodeSniffer can print you a list of the sniffs that a coding standard includes by specifying the `-e` (="explain") command line argument along with the `--standard` argument. This allows you to see what checks will be applied when you use a given standard.

```bash
$ phpcs --standard=PSR1 -e
{{COMMAND-OUTPUT "phpcs --standard=PSR1 -e"}}
```

<p align="right"><a href="#table-of-contents">back to top</a></p>
