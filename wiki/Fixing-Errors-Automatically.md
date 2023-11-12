## Table of contents

<!-- START doctoc -->
<!-- END doctoc -->

***

## About Automatic Fixing

PHP_CodeSniffer is able to fix many errors and warnings automatically. The PHP Code Beautifier and Fixer (`phpcbf`) can be used instead of `phpcs` to automatically generate and apply the fixes for you.

Screen-based reports, such as the [full](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki/Reporting#printing-full-and-summary-reports), [summary](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki/Reporting#printing-full-and-summary-reports) and [source](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki/Reporting#printing-a-source-report) reports, provide information about how many errors and warnings are found. If any of the issues can be fixed automatically by `phpcbf`, this will be annotated in the report with the `[x]` markings:

```bash
$ phpcs path/to/code/fileA.php
{{COMMAND-OUTPUT "phpcs --parallel=1 --no-cache --no-colors --report-width=100 --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php"}}
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

<!--
Regenerate the below output snippet by running the following command:
$ phpcs -vv --parallel=1 --no-cache --no-colors --report-width=100 --report=diff --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileB.php
-->
```bash
$ phpcs /path/to/file --report=diff -vv
..snip..
*** START FILE FIXING ***
E: [Line 3] PHP keywords must be lowercase; expected "namespace" but found "NAMESPACE" (Generic.PHP.LowerCaseKeyword.Found)
Generic.PHP.LowerCaseKeyword:76 replaced token 3 (T_NAMESPACE on line 3) "NAMESPACE" => "namespace"
* fixed 1 violations, starting loop 2 *
*** END FILE FIXING ***
```

Sometimes the file may need to be processed multiple times in order to fix all the violations. This can happen when multiple sniffs need to modify the same part of a file, or if a fix causes a new sniff violation somewhere else in the standard. When this happens, the output will look like this:

<!--
Regenerate the below output snippet by running the following command:
$ phpcs -vv --parallel=1 --no-cache --no-colors --report-width=100 --report=diff --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php
-->
```bash
$ phpcs /path/to/file --report=diff -vv
..snip..
*** START FILE FIXING ***
E: [Line 1] Header blocks must be separated by a single blank line (PSR12.Files.FileHeader.SpacingAfterTagBlock)
PSR12.Files.FileHeader:311 replaced token 0 (T_OPEN_TAG on line 1) "<?php" => "<?php\n"
E: [Line 13] Line indented incorrectly; expected at least 8 spaces, found 4 (Generic.WhiteSpace.ScopeIndent.Incorrect)
Generic.WhiteSpace.ScopeIndent:1353 replaced token 51 (T_WHITESPACE on line 13) "    return" => "        return"
E: [Line 10] PHP parameter type declarations must be lowercase; expected "string" but found "String" (Generic.PHP.LowerCaseType.ParamTypeFound)
Generic.PHP.LowerCaseType:353 replaced token 33 (T_STRING on line 10) "String" => "string"
E: [Line 10] Expected 1 space between type hint and argument "$param"; 2 found (Squiz.Functions.FunctionDeclarationArgumentSpacing.SpacingAfterHint)
=> Changeset started by Squiz.Functions.FunctionDeclarationArgumentSpacing:291
    Q: Squiz.Functions.FunctionDeclarationArgumentSpacing:292 replaced token 33 (T_STRING on line 10) "string" => "string "
    Q: Squiz.Functions.FunctionDeclarationArgumentSpacing:295 replaced token 34 (T_WHITESPACE on line 10) "  $param" => "$param"
    * token 33 has already been modified, skipping *
=> Changeset failed to apply
E: [Line 10] Expected 0 spaces after opening parenthesis; 1 found (Squiz.Functions.FunctionDeclarationArgumentSpacing.SpacingAfterOpen)
Squiz.Functions.FunctionDeclarationArgumentSpacing:560 replaced token 32 (T_WHITESPACE on line 10) " string" => "string"
E: [Line 13] TRUE, FALSE and NULL must be lowercase; expected "false" but found "FALSE" (Generic.PHP.LowerCaseConstant.Found)
Generic.PHP.LowerCaseConstant:262 replaced token 54 (T_FALSE on line 13) "FALSE" => "false"
* fixed 5 violations, starting loop 2 *
E: [Line 11] Expected 1 space between type hint and argument "$param"; 2 found (Squiz.Functions.FunctionDeclarationArgumentSpacing.SpacingAfterHint)
=> Changeset started by Squiz.Functions.FunctionDeclarationArgumentSpacing:291
    Q: Squiz.Functions.FunctionDeclarationArgumentSpacing:292 replaced token 33 (T_STRING on line 11) "string" => "string "
    Q: Squiz.Functions.FunctionDeclarationArgumentSpacing:295 replaced token 34 (T_WHITESPACE on line 11) "  $param" => "$param"
    A: Squiz.Functions.FunctionDeclarationArgumentSpacing:298 replaced token 33 (T_STRING on line 11) "string" => "string "
    A: Squiz.Functions.FunctionDeclarationArgumentSpacing:298 replaced token 34 (T_WHITESPACE on line 11) "  $param" => "$param"
=> Changeset ended: 2 changes applied
* fixed 2 violations, starting loop 3 *
*** END FILE FIXING ***
```

<p align="right"><a href="#table-of-contents">back to top</a></p>
