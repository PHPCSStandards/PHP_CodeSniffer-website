## Table of contents

<!-- START doctoc -->
<!-- END doctoc -->

***

## About Automatic Fixing

PHP_CodeSniffer is able to fix many errors and warnings automatically. The PHP Code Beautifier and Fixer (`phpcbf`) can be used instead of `phpcs` to automatically generate and apply the fixes for you.

Screen-based reports, such as the [full](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki/Reporting#printing-full-and-summary-reports), [summary](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki/Reporting#printing-full-and-summary-reports) and [source](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki/Reporting#printing-a-source-report) reports, provide information about how many errors and warnings are found. If any of the issues can be fixed automatically by `phpcbf`, this will be annotated in the report with the `[x]` markings:

```bash
$ phpcs /path/to/code/myfile.php

FILE: /path/to/code/myfile.php
--------------------------------------------------------------------------------
FOUND 5 ERRORS AFFECTING 4 LINES
--------------------------------------------------------------------------------
 2 | ERROR | [ ] Missing file doc comment
 3 | ERROR | [x] TRUE, FALSE and NULL must be lowercase; expected "false" but
   |       |     found "FALSE"
 5 | ERROR | [x] Line indented incorrectly; expected at least 4 spaces, found 1
 8 | ERROR | [ ] Missing function doc comment
 8 | ERROR | [ ] Opening brace should be on a new line
--------------------------------------------------------------------------------
PHPCBF CAN FIX THE 2 MARKED SNIFF VIOLATIONS AUTOMATICALLY
--------------------------------------------------------------------------------
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Using the PHP Code Beautifier and Fixer

To automatically fix as many sniff violations as possible, use the `phpcbf` command instead of the `phpcs` command. While most of the PHPCS command line arguments can be used by PHPCBF, some are specific to reporting and will be ignored. Running PHPCBF with the `-h` or `--help` command line arguments will print a list of commands that PHPCBF will respond to. The output of `phpcbf -h` is shown below.
```text
{{COMMAND-OUTPUT "phpcbf --report-width=110 --no-colors -h"}}
```

When using the PHPCBF command, you do not need to specify a report type. PHPCBF will automatically make changes to your source files:

<!--
Regenerate the below output snippet by running the following command from the PHP_CodeSniffer project root directory:
$ phpcbf ./src/Runner.php ./src/Config.php --standard=PSR12 --basepath=./ --report-width=100
WARNING: DO NOT COMMIT THE RESULT!
-->
```bash
$ phpcbf /path/to/code

PHPCBF RESULT SUMMARY
----------------------------------------------------------------------
FILE                                                  FIXED  REMAINING
----------------------------------------------------------------------
src/Runner.php                                        95     16
src/Config.php                                        889    38
----------------------------------------------------------------------
A TOTAL OF 984 ERRORS WERE FIXED IN 2 FILES
----------------------------------------------------------------------
```

If you do not want to overwrite existing files, you can specify the `--suffix` command line argument and provide a filename suffix to use for new files. A fixed copy of each file will be created and stored in the same directory as the original file. If a file already exists with the new name, it will be overwritten.

<!--
Regenerate the below output snippet by running the following command from the PHP_CodeSniffer project root directory:
$ phpcbf -v ./src/Runner.php ./src/Config.php --standard=PSR12 --suffix=.fixed --basepath=./ --report-width=100
WARNING: DO NOT COMMIT THE RESULT!
-->
```bash
$ phpcbf -v /path/to/code --suffix=.fixed

Creating file list... DONE (2 files in queue)
Changing into directory src
Processing Runner.php [6415 tokens in 907 lines]... DONE in 193ms (91 fixable errors, 4 fixable warnings)
    => Fixing file: 0/95 violations remaining [made 4 passes]... DONE in 771ms
    => Fixed file written to Runner.php.fixed
Processing Config.php [13891 tokens in 1792 lines]... DONE in 444ms (865 fixable errors, 24 fixable warnings)
    => Fixing file: 0/889 violations remaining [made 4 passes]... DONE in 1.72 secs
    => Fixed file written to Config.php.fixed

PHPCBF RESULT SUMMARY
----------------------------------------------------------------------
FILE                                                  FIXED  REMAINING
----------------------------------------------------------------------
src/Runner.php                                        95     16
src/Config.php                                        889    38
----------------------------------------------------------------------
A TOTAL OF 984 ERRORS WERE FIXED IN 2 FILES
----------------------------------------------------------------------
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Viewing Debug Information

To see the fixes that are being made to a file, specify the `-vv` command line argument when generating a diff report. There is quite a lot of debug output concerning the standard being used and the tokenizing of the file, but the end of the output will look like this:

```bash
$ phpcs /path/to/file --report=diff -vv
..snip..
*** START FILE FIXING ***
E: [Line 3] Expected 1 space after "="; 0 found (Squiz.WhiteSpace.OperatorSpacing.NoSpaceAfter)
Squiz_Sniffs_WhiteSpace_OperatorSpacingSniff (line 259) replaced token 4 (T_EQUAL) "=" => "=·"
* fixed 1 violations, starting loop 2 *
*** END FILE FIXING ***
```

Sometimes the file may need to be processed multiple times in order to fix all the violations. This can happen when multiple sniffs need to modify the same part of a file, or if a fix causes a new sniff violation somewhere else in the standard. When this happens, the output will look like this:

```bash
$ phpcs /path/to/file --report=diff -vv
..snip..
*** START FILE FIXING ***
E: [Line 3] Expected 1 space before "="; 0 found (Squiz.WhiteSpace.OperatorSpacing.NoSpaceBefore)
Squiz_Sniffs_WhiteSpace_OperatorSpacingSniff (line 228) replaced token 3 (T_EQUAL) "=" => "·="
E: [Line 3] Expected 1 space after "="; 0 found (Squiz.WhiteSpace.OperatorSpacing.NoSpaceAfter)
* token 3 has already been modified, skipping *
E: [Line 3] Equals sign not aligned correctly; expected 1 space but found 0 spaces (Generic.Formatting.MultipleStatementAlignment.Incorrect)
* token 3 has already been modified, skipping *
* fixed 1 violations, starting loop 2 *
E: [Line 3] Expected 1 space after "="; 0 found (Squiz.WhiteSpace.OperatorSpacing.NoSpaceAfter)
Squiz_Sniffs_WhiteSpace_OperatorSpacingSniff (line 259) replaced token 4 (T_EQUAL) "=" => "=·"
* fixed 1 violations, starting loop 3 *
*** END FILE FIXING ***
```

<p align="right"><a href="#table-of-contents">back to top</a></p>
