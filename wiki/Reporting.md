## Table of contents

* [Printing Full and Summary Reports](#printing-full-and-summary-reports)
* Other Report Types
    * [Checkstyle](#printing-a-checkstyle-report)
    * [Code](#printing-a-code-report)
    * [CSV](#printing-a-csv-report)
    * [Diff](#printing-a-diff-report)
    * [Emacs](#printing-an-emacs-report)
    * [Git Blame](#printing-a-git-blame-report)
    * HG Blame
    * [Information](#printing-an-information-report)
    * [JSON](#printing-a-json-report)
    * [JUnit](#printing-a-junit-report)
    * Notify-Send
    * [Performance](#printing-a-performance-report)
    * [Source](#printing-a-source-report)
    * [SVN Blame](#printing-an-svn-blame-report)
    * [XML](#printing-an-xml-report)
* [Printing Multiple Reports](#printing-multiple-reports)
* [Running Interactively](#running-interactively)
* [Specifying a Report Width](#specifying-a-report-width)
* [Writing a Report to a File](#writing-a-report-to-a-file)

***

## Printing Full and Summary Reports

When running a scan, by default, the full report is displayed.

```bash
$ phpcs path/to/code/fileA.php
{{COMMAND-OUTPUT "phpcs --parallel=1 --no-cache --no-colors --report-width=100 --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php"}}
```

To see a summary of the errors and warnings per file, use the `--report=summary` option.

```bash
$ phpcs --report=summary /path/to/code
{{COMMAND-OUTPUT "phpcs --parallel=1 --no-cache --no-colors --report-width=100 --report=summary --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code"}}
```

The full report can also show information about the source of errors and warnings. To include source codes in the report,
use the `-s` command line argument.

```bash
$ phpcs -s path/to/code/fileA.php
{{COMMAND-OUTPUT "phpcs -s --parallel=1 --no-cache --no-colors --report-width=100 --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php"}}
```

Source codes can be used with the `--sniffs` command line argument to only show messages from a specified list of sources
and with the `--exclude` command line argument to silence the messages from a specified list of sources.
[Learn how](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki/Advanced-Usage#limiting-results-to-specific-sniffs).

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing a Source Report

PHP_CodeSniffer can output a summary report showing you the most common errors detected in your files so you can target specific parts of your coding standard for improvement. To print a source report, use the `--report=source` command line argument. The output will look like this:

```bash
$ phpcs --report=source /path/to/code
{{COMMAND-OUTPUT "phpcs --parallel=1 --no-cache --no-colors --report-width=100 --report=source --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php"}}
```

To show source codes instead of friendly names, use the `-s` command line argument.

```bash
$ phpcs -s --report=source /path/to/code
{{COMMAND-OUTPUT "phpcs -s --parallel=1 --no-cache --no-colors --report-width=100 --report=source --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php"}}
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing an Information Report

PHP_CodeSniffer can output an information report to show you how your code is written rather than checking that it conforms to a standard. This report will use one or more standards you pass to it and then use the sniffs within those standards to inspect your code. Sniffs must be written to support recording metrics for this feature, so not all sniffs will report back information. To print an information report, use the `--report=info` command line argument. The output will look like this:

```bash
$ phpcs --report=info /path/to/code

PHP CODE SNIFFER INFORMATION REPORT
--------------------------------------------------------------------------------
Class has doc comment: yes [10/10, 100%]

Class opening brace placement: new line [10/10, 100%]

Constant name case: upper [81/81, 100%]

Control structure defined inline: no [863/863, 100%]

EOL char: \n [10/10, 100%]

File has doc comment: yes [10/10, 100%]

Function has doc comment: yes [130/130, 100%]

Function opening brace placement: new line [111/111, 100%]

Inline comment style: // ... [585/594, 98.48%]
    /* ... */ => 9 (1.52%)

Line indent: spaces [5099/5099, 100%]

Line length: 80 or less [6723/7134, 94.24%]
    81-120 => 397 (5.56%)
    121-150 => 10 (0.14%)
    151 or more => 4 (0.06%)

PHP constant case: lower [684/684, 100%]

PHP short open tag used: no [10/10, 100%]

Private method prefixed with underscore: yes [11/11, 100%]

--------------------------------------------------------------------------------
```

When more than one variation is found for a particular coding convention, the most common variation is printed on the first line and the other variations that were found are indented on subsequent lines. Each convention is followed by a number and each variation followed by a percentage, indicating the number of times the convention was checked and the percentage of code using each variation.

In the example above, the `Inline comment style` convention was checked 594 times, indicating that 594 inline comments were found and checked. 585 of them (98.48%) used the `// ...` style variation and 9 of them (1.52%) used the `/* ... */` style variation.

> **Tip:** To check your code against a wide range of conventions, specify all included standards. This will take longer, but gives you more information about your code: `phpcs --standard=Generic,PEAR,Squiz,PSR2,Zend --report=info /path/to/code`

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing a Code Report

PHP_CodeSniffer can output a report that shows a code snippet for each error and warning, showing the context in which the violation has occurred. The output will look like this:

```bash
$ phpcs --report=code /path/to/code/fileA.php
{{COMMAND-OUTPUT "phpcs --parallel=1 --no-cache --no-colors --report-width=100 --report=code --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php"}}
```

> [!NOTE]
> The code report shows up to 5 lines of source code for each violation, so it is best used when checking single files and short code snippets to ensure the report doesn't become unreadable due to its length.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing a Checkstyle Report

PHP_CodeSniffer can output an XML report similar to the one produced by Checkstyle, allowing you to use the output in scripts and applications that already support Checkstyle. To print a Checkstyle report, use the `--report=checkstyle` command line argument. The output will look like this:

```bash
$ phpcs --report=checkstyle /path/to/code
```
```xml
{{COMMAND-OUTPUT "phpcs --parallel=1 --no-cache --no-colors --report-width=100 --report=checkstyle --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php"}}
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing a CSV Report

PHP_CodeSniffer can output a CSV report to allow you to parse the output and use the results in your own scripts. To print a CSV report, use the `--report=csv` command line argument. The output will look like this:

```bash
$ phpcs --report=csv /path/to/code
```
```csv
{{COMMAND-OUTPUT "phpcs --parallel=1 --no-cache --no-colors --report-width=100 --report=csv --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php"}}
```

> [!IMPORTANT]
> The first row of the CSV output defines the order of information. When using the CSV output, please parse this header row to determine the order correctly as the format may change over time or new information may be added.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing a Diff Report

> [!TIP]
> Use the [`phpcbf` script](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki/Fixing-Errors-Automatically) instead to automatically fix scanned files.

PHP_CodeSniffer can output a diff file that can be applied using the `patch` command. The suggested changes will fix some of the sniff violations that are present in the source code. To print a diff report, use the `--report=diff` command line argument. The output will look like this:

<!--
Regenerate the below output snippet by running the following command:
$ phpcs --parallel=1 --no-cache --no-colors --report-width=100 --report=diff --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileB.php
-->
```bash
$ phpcs --report=diff /path/to/code
```
```diff
--- path/to/code/fileB.php
+++ PHP_CodeSniffer
@@ -1,7 +1,7 @@
 <?php

-NAMESPACE Foo;
+namespace Foo;

 if ($foo) {
-} else if ($bar) {
+} elseif ($bar) {
 }
```

Diff reports are more straight-forward to use when output to a file. They can then be applied using the `patch` command:

```bash
$ phpcs --report-diff=/path/to/changes.diff /path/to/code
$ patch -p0 -ui /path/to/changes.diff
patching file /path/to/code/fileB.php
```

> [!NOTE]
> The `*nix` `diff` command is required for generating reports in `diff` format. Windows users may need to ensure that the `diff` command is available by either installing [DiffUtils](http://gnuwin32.sourceforge.net/packages/diffutils.htm) or, if available, adding the Git `/usr/bin/` sub-directory to the Windows system `PATH`.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing an Emacs Report

PHP_CodeSniffer can output a report in a format the compiler built into the GNU Emacs text editor can understand. This lets you use the built-in compiler to run PHP_CodeSniffer on a file you are editing and navigate between errors and warnings within the file. To print an Emacs report, use the `--report=emacs` command line argument. The output will look like this:

```bash
$ phpcs --report=emacs /path/to/code

{{COMMAND-OUTPUT "phpcs --parallel=1 --no-cache --no-colors --report-width=100 --report=emacs --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php"}}
```

To use PHP_CodeSniffer with Emacs, make sure you have installed PHP mode for Emacs. Then put the following into your .emacs file, changing PHP_CodeSniffer options as required.

```emacs
(require 'compile)
(defun my-php-hook-function ()
 (set (make-local-variable 'compile-command) (format "phpcs --report=emacs --standard=PSR12 %s" (buffer-file-name))))
(add-hook 'php-mode-hook 'my-php-hook-function)
```

Now you can use the compile command and associated shortcuts to move between error messages within your file.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing a Git Blame Report

PHP_CodeSniffer can make use of the `git blame` command to try and determine who committed each error and warning to a Git repository. To print a Git Blame report, use the `--report=gitblame` command line argument. The output will look like this:

```bash
$ phpcs --report=gitblame /path/to/code

PHP CODE SNIFFER GIT BLAME SUMMARY
----------------------------------------------------------------------
AUTHOR                                    (Author %) (Overall %) COUNT
----------------------------------------------------------------------
jsmith                                        (2.25)     (61.11)    33
jblogs                                        (2.48)     (29.63)    16
pdeveloper                                    (0.78)      (5.56)     3
jscript                                       (1.39)      (1.85)     1
toogood                                       (3.33)      (1.85)     1
----------------------------------------------------------------------
A TOTAL OF 54 SNIFF VIOLATIONS WERE COMMITTED BY 5 AUTHORS
----------------------------------------------------------------------
```

Each author is listed with the number of violations they committed and the percentage of error lines to clean lines. The example report above shows that the developer `jscript` has 1 violation but they only make up 1.39% of all code they have committed, while `toogood` has 1 violation but they make up 3.33% of all their committed code. So these developers have about the same number of total violations, but `jscript` seems to be doing a better job of conforming to the coding standard.


To show a breakdown of the types of violations each author is committing, use the `-s` command line argument.

```bash
$ phpcs -s --report=gitblame /path/to/code

PHP CODE SNIFFER GIT BLAME SUMMARY
--------------------------------------------------------------------------------
AUTHOR   SOURCE                                     (Author %) (Overall %) COUNT
--------------------------------------------------------------------------------
jsmith                                                  (2.25)     (61.11)    33
         Generic.Files.LineLength.TooLong                                     22
         PEAR.Functions.FunctionCallSignature                                  1
jblogs                                                  (2.48)     (29.63)    16
         Squiz.Formatting.MultipleStatementAlignment                          10
         PSR12.Classes.ClosingBrace.StatementAfter                             4
         Generic.Files.LineLength.TooLong                                      2
pdeveloper                                              (0.78)      (5.56)     3
         Generic.CodeAnalysis.UnusedFunctionParameter                          3
jscript                                                 (1.39)      (1.85)     1
         Squiz.CodeAnalysis.EmptyStatement                                     1
toogood                                                 (3.33)      (1.85)     1
         PSR12.Classes.ClosingBrace.StatementAfter                             1
--------------------------------------------------------------------------------
A TOTAL OF 54 SNIFF VIOLATIONS WERE COMMITTED BY 5 AUTHORS
--------------------------------------------------------------------------------
```

To include authors with no violations, use the `-v` command line argument.

```bash
$ phpcs -v --report=gitblame /path/to/code

PHP CODE SNIFFER GIT BLAME SUMMARY
----------------------------------------------------------------------
AUTHOR                                    (Author %) (Overall %) COUNT
----------------------------------------------------------------------
jsmith                                        (2.25)     (61.11)    33
jblogs                                        (2.48)     (29.63)    16
pdeveloper                                    (0.78)      (5.56)     3
jscript                                       (1.39)      (1.85)     1
toogood                                       (3.33)      (1.85)     1
mrsperfect                                       (0)         (0)     0
----------------------------------------------------------------------
A TOTAL OF 54 SNIFF VIOLATIONS WERE COMMITTED BY 6 AUTHORS
----------------------------------------------------------------------
```

> [!IMPORTANT]
> You need to make sure the location of the `git` command is in your path. If the command is not in your path, the report will fail to generate.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing a JSON Report

PHP_CodeSniffer can output a JSON report to allow you to parse the output and use the results in your own scripts. To print a JSON report, use the `--report=json` command line argument. The output will look like this:

<!--
Regenerate the below output snippet by running the following command and then pretty formatting the JSON output:
$ phpcs -n --parallel=1 --no-cache --no-colors --report-width=100 --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php build/wiki-code-samples/path/to/code/fileC.php --report=json
-->
```bash
$ phpcs --report=json /path/to/code
```
```json
{
  "totals": {
    "errors": 6,
    "warnings": 0,
    "fixable": 6
  },
  "files": {
    "\/path\/to\/code\/fileA.php": {
      "errors": 6,
      "warnings": 0,
      "messages": [
        {
          "message": "Header blocks must be separated by a single blank line",
          "source": "PSR12.Files.FileHeader.SpacingAfterTagBlock",
          "severity": 5,
          "fixable": true,
          "type": "ERROR",
          "line": 1,
          "column": 1
        },
        {
          "message": "Expected 0 spaces after opening parenthesis; 1 found",
          "source": "Squiz.Functions.FunctionDeclarationArgumentSpacing.SpacingAfterOpen",
          "severity": 5,
          "fixable": true,
          "type": "ERROR",
          "line": 10,
          "column": 24
        },
        {
          "message": "PHP parameter type declarations must be lowercase; expected \"string\" but found \"String\"",
          "source": "Generic.PHP.LowerCaseType.ParamTypeFound",
          "severity": 5,
          "fixable": true,
          "type": "ERROR",
          "line": 10,
          "column": 26
        },
        {
          "message": "Expected 1 space between type hint and argument \"$param\"; 2 found",
          "source": "Squiz.Functions.FunctionDeclarationArgumentSpacing.SpacingAfterHint",
          "severity": 5,
          "fixable": true,
          "type": "ERROR",
          "line": 10,
          "column": 26
        },
        {
          "message": "Line indented incorrectly; expected at least 8 spaces, found 4",
          "source": "Generic.WhiteSpace.ScopeIndent.Incorrect",
          "severity": 5,
          "fixable": true,
          "type": "ERROR",
          "line": 13,
          "column": 5
        },
        {
          "message": "TRUE, FALSE and NULL must be lowercase; expected \"false\" but found \"FALSE\"",
          "source": "Generic.PHP.LowerCaseConstant.Found",
          "severity": 5,
          "fixable": true,
          "type": "ERROR",
          "line": 13,
          "column": 12
        }
      ]
    },
    "\/path\/to\/code\/fileC.php": {
      "errors": 0,
      "warnings": 0,
      "messages": []
    }
  }
}
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing a JUnit Report

PHP_CodeSniffer can output an XML report similar to the one produced by JUnit, allowing you to use the output in scripts and applications that already support JUnit. To print a JUnit report, use the `--report=junit` command line argument. The output will look like this:

```bash
$ phpcs --report=junit /path/to/code
```
```xml
{{COMMAND-OUTPUT "phpcs -n --parallel=1 --no-cache --no-colors --report-width=100 --report=junit --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php build/wiki-code-samples/path/to/code/fileC.php"}}
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing a Performance Report

PHP_CodeSniffer can output a sniff performance report showing you which sniffs in the standard you use are _slowest_. This can be useful information to examine when a PHP_CodeSniffer run takes a long time to finish and will provide you with insights to share with the developers of the sniffs you use.

When the `--colors` option is enabled, sniffs which take more than twice the average run time per sniff will be displayed in orange and sniffs with a cumulative listener run time of more than three times the average run time per sniff will display in red.

> [!NOTE]
> The Performance report will only be useful when run without using the cache as otherwise the cache functionality will interfere with accurately measuring the runtime of sniffs.
> So make sure to always use the `--no-cache` feature when running Performance reports.

> [!NOTE]
> Enabling the performance report, in and of itself will make a PHP_CodeSniffer run slower. This is nothing to worry about as the exact time taken for each sniff isn't that relevant, it's the relative time taken _in comparison to other sniffs_ which is the interesting part.

> [!NOTE]
> A sniff being "slow" can be due to the complexity of the sniff, in which case, this is to be expected.
> Also keep in mind that the sniff run-time will often be influenced by whether or not the sniff finds errors in your code.

To print a performance report, use the `--report=performance` command line argument. The output will look like this:

```bash
$ phpcs --report=performance /path/to/code --no-cache

PHP CODE SNIFFER SNIFF PERFORMANCE REPORT
--------------------------------------------------------------------------------
SNIFF                                                 TIME TAKEN (SECS)     (%)
--------------------------------------------------------------------------------
Generic.NamingConventions.UpperCaseConstantName               0.074654 ( 44.6 %)
PSR1.Files.SideEffects                                        0.028242 ( 16.9 %)
PSR1.Methods.CamelCapsMethodName                              0.027005 ( 16.2 %)
PSR1.Classes.ClassDeclaration                                 0.021653 ( 13.0 %)
Squiz.Classes.ValidClassName                                  0.010412 (  6.2 %)
Generic.PHP.DisallowAlternativePHPTags                        0.002662 (  1.6 %)
Generic.PHP.DisallowShortOpenTag                              0.002560 (  1.5 %)
Generic.Files.ByteOrderMark                                   0.000012 (  0.0 %)
--------------------------------------------------------------------------------
TOTAL SNIFF PROCESSING TIME                                   0.167201 (100.0 %)
--------------------------------------------------------------------------------
Time taken by sniffs                                          0.167201 (  1.2 %)
Time taken by PHPCS runner                                   13.336752 ( 98.8 %)
--------------------------------------------------------------------------------
TOTAL RUN TIME                                               13.503953 (100.0 %)
--------------------------------------------------------------------------------
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing an SVN Blame Report

Like the Git Blame report, PHP_CodeSniffer can make use of the `svn blame` command to try and determine who committed each error and warning to an SVN repository. To print an SVN Blame report, use the `--report=svnblame` command line argument. The output and options are the same as those described in the [Git Blame report](#printing-a-git-blame-report).

> [!IMPORTANT]
> You need to make sure the location of the `svn` command is in your path and that SVN is storing a username and password (if required by your repository). If the command is not in your path, the report will fail to generate. If SVN does not have a username and password stored, you'll need to enter it for each file being checked by PHP_CodeSniffer that contains violations.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing an XML Report

PHP_CodeSniffer can output an XML report to allow you to parse the output and use the results in your own scripts. To print an XML report, use the `--report=xml` command line argument. The output will look like this:

```bash
$ phpcs --report=xml /path/to/code
```
```xml
{{COMMAND-OUTPUT "phpcs -n --parallel=1 --no-cache --no-colors --report-width=100 --report=xml --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php"}}
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Printing Multiple Reports

PHP_CodeSniffer can print any combination of the above reports to either the screen or to separate files. To print multiple reports, use the `--report-[type]` command line argument instead of the standard `--report=[type]` format. You can then specify multiple reports using multiple arguments. The reports will be printed to the screen in the order you specify them on the command line.

The following command will write both a full and summary report to the screen

```bash
$ phpcs --report-full --report-summary /path/to/code
```

You can write the reports to separate files by specifying the path to the output file after each report argument.

```bash
$ phpcs --report-full=/path/to/full.txt --report-summary=/path/to/summary.txt /path/to/code
```

You can print some reports to the screen and other reports to files. The following command will write the full report to a file and a summary report to the screen.

```bash
$ phpcs --report-full=/path/to/full.txt --report-summary /path/to/code
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Running Interactively

Instead of producing a single report at the end of a run, PHP_CodeSniffer can run interactively and show reports for files one at a time. When using the interactive mode, PHP_CodeSniffer will show a report for the first file it finds an error or warning in. It will then pause and wait for user input. Once you have corrected the errors, you can press `ENTER` to have PHP_CodeSniffer recheck your file and continue if the file is now free of errors. You can also choose to skip the file and move to the next file with errors.

To run PHP_CodeSniffer interactively, use the `-a` command line argument.

```bash
$ phpcs -a /path/to/code

{{COMMAND-OUTPUT "phpcs -q --parallel=1 --no-cache --no-colors --report-width=100 --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php"}}

<ENTER> to recheck, [s] to skip or [q] to quit :
```

> [!NOTE]
> PHP_CodeSniffer will always print the full error report for a file when running in interactive mode. Any report types you specify on the command line will be ignored.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Specifying a Report Width

By default, PHP_CodeSniffer will print all screen-based reports 80 characters wide. File paths will be truncated if they don't fit within this limit and error messages will be wrapped across multiple lines. You can increase the report width to show longer file paths and limit the wrapping of error messages using the `--report-width` command line argument.

```bash
$ phpcs --report-width=120 --report=summary /path/to/code/myfile.php
```

> [!NOTE]
> If you want reports to fill the entire terminal width (in supported terminals), set the `--report-width` command line argument to `auto`.
>
> ```bash
> $ phpcs --report-width=auto --report=summary /path/to/code/myfile.php
> ```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Writing a Report to a File

PHP_CodeSniffer always prints the specified report to the screen, but it can also be told to write a copy of the report to a file. When writing to a file, all internal parsing errors and verbose output PHP_CodeSniffer produces will not be included in the file. This feature is particularly useful when using report types such as XML and CSV that are often parsed by scripts or used with continuous integration software.

To write a copy of a report to a file, use the `--report-file` command line argument.

```bash
$ phpcs --report=xml --report-file=/path/to/file.xml /path/to/code
```

> [!WARNING]
> The report will not be written to the screen when using this option. If you still want to view the report, use the -v command line argument to print verbose output.

<p align="right"><a href="#table-of-contents">back to top</a></p>
