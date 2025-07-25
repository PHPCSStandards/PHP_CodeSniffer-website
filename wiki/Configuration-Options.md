## Table of contents

<!-- START doctoc -->
<!-- END doctoc -->

***

## Setting the default coding standard

By default, PHP_CodeSniffer will use the PEAR coding standard if no standard is supplied on the command line. You can change the default standard by setting the `default_standard` configuration option.

```bash
$ phpcs --config-set default_standard Squiz
```

> [!NOTE]
> This configuration option cannot be set using the `--runtime-set` command line argument. To set the coding standard for a single run only, use the `--standard` command line argument.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Setting the default report format

By default, PHP_CodeSniffer will use the full report format if no format is supplied on the command line. You can change the default report format by setting the `report_format` configuration option.

```bash
$ phpcs --config-set report_format summary
```

> [!NOTE]
> This configuration option cannot be set using the `--runtime-set` command line argument. To set the report format for a single run only, use the `--report` command line argument.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Hiding warnings by default

By default, PHP_CodeSniffer will show both errors and warnings for your code. You can hide warnings for a single script run by using the `-n` command line argument, but you can also enable this by default if you prefer. To hide warnings by default, set the `show_warnings` configuration option to `0`.

```bash
$ phpcs --config-set show_warnings 0
```

> [!NOTE]
> This configuration option cannot be set using the `--runtime-set` command line argument. To hide warnings for a single run only, use the `-n` command line argument.

> Note: When warnings are hidden by default, you can use the `-w` command line argument to show them for a single script run.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Showing progress by default

By default, PHP_CodeSniffer will run quietly and only print the report of errors and warnings at the end. If you want to know what is happening you can turn on progress output, but you can also enable this by default if you prefer. To show progress by default, set the `show_progress` configuration option to `1`.

```bash
$ phpcs --config-set show_progress 1
```

> [!NOTE]
> This configuration option cannot be set using the `--runtime-set` command line argument. To show progress for a single run only, use the `-p` command line argument.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Using colors in output by default

By default, PHP_CodeSniffer will not use colors in progress or report screen output. To use colors in output by default, set the `colors` configuration option to `1`.

```bash
$ phpcs --config-set colors 1
```

> [!NOTE]
> This configuration option cannot be set using the `--runtime-set` command line argument. To show colors for a single run only, use the `--colors` command line argument.
>
> When colors are being used by default, you can use the `--no-colors` command line argument to disable them for a single script run.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Changing the default severity levels

By default, PHP_CodeSniffer will show all errors and warnings with a severity level of 5 or greater. You can change these settings for a single script run by using the `--severity`, `--error-severity` and `--warning-severity` command line arguments, but you can also change the default settings if you prefer.

To change the default severity level to show all errors and warnings:

```bash
$ phpcs --config-set severity 1
```

To change the default severity levels to show all errors but only some warnings

```bash
$ phpcs --config-set error_severity 1
$ phpcs --config-set warning_severity 8
```

> [!NOTE]
> Setting the severity of warnings to 0 is the same as using the `-n` command line argument. If you set the severity of errors to `0` PHP_CodeSniffer will not show any errors, which may be useful if you just want to show warnings.

> [!NOTE]
> These configuration options cannot be set using the `--runtime-set` command line argument. To change severity levels for a single run only, use the `--severity`, `--error-severity`, and `--warning-severity` command line arguments.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Setting the default report width

By default, PHP_CodeSniffer will print all screen-based reports 80 characters wide. File paths will be truncated if they don't fit within this limit and error messages will be wrapped across multiple lines. You can increase the report width to show longer file paths and limit the wrapping of error messages using the `--report-width` command line argument, but you can also change the default report width by setting the `report_width` configuration option.

```bash
$ phpcs --config-set report_width 120
```

> [!NOTE]
> This configuration option cannot be set using the `--runtime-set` command line argument. To set the report width for a single run only, use the `--report-width` command line argument.

> [!NOTE]
> If you want reports to fill the entire terminal width (in supported terminals), set the `report_width` config configuration option to `auto`.
> ```bash
> $phpcs --config-set report_width auto
> ```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Setting the default encoding

By default, PHP_CodeSniffer will treat all source files as if they use UTF-8 encoding. If you need your source files to be processed using a specific encoding, you can specify the encoding using the `--encoding` command line argument, but you can also change the default encoding by setting the `encoding` configuration option.

```bash
$ phpcs --config-set encoding windows-1251
```

> [!NOTE]
> This configuration option cannot be set using the `--runtime-set` command line argument. To set the encoding for a single run only, use the `--encoding` command line argument.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Setting the default tab width

By default, PHP_CodeSniffer will not convert tabs to spaces in checked files. Specifying a tab width will make PHP_CodeSniffer replace tabs with spaces. You can force PHP_CodeSniffer to replace tabs with spaces by default by setting the `tab_width` configuration option.

```bash
$ phpcs --config-set tab_width 4
```

> [!NOTE]
> This configuration option cannot be set using the `--runtime-set` command line argument. To set the tab width for a single run only, use the `--tab-width` command line argument.

When the tab width is set by default, the replacement of tabs with spaces can be disabled for a single script run by setting the tab width to zero.

```bash
$ phpcs --tab-width=0 /path/to/code
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Setting the installed standard paths

By default, PHP_CodeSniffer will look inside its own `src/Standards` directory to find installed coding standards. An installed standard appears when you use the `-i` command line argument and can be referenced using a name instead of a path when using the `--standard` command line argument. You can add install paths by setting the `installed_paths` configuration option.

```bash
$ phpcs --config-set installed_paths /path/to/one,/path/to/two
```

> [!NOTE]
> If you want to use relative paths, ensure they begin with `./` (e.g., `./path/to/one`) or PHP_CodeSniffer will assume the path is absolute. Relative paths should always be defined relative to the top-level PHP_CodeSniffer install directory (i.e., the directory that contains the `src` sub-directory).

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Setting the PHP version

Some sniffs change their behaviour based on the version of PHP being used to run PHPCS. For example, a sniff that checks for namespaces may choose to ignore this check if the version of PHP does not include namespace support. Sometimes a code base that supports older PHP versions is checked using a newer PHP version. In this case, sniffs see the new PHP version and report errors that may not be correct. To let the sniffs know what version of PHP you are targeting, the `php_version` configuration option can be used.

```bash
$ phpcs --config-set php_version 70416
```

> [!IMPORTANT]
> The format of the `php_version` value is the same as the `PHP_VERSION_ID` constant. E.g. `70416` for version `7.4.16`.

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Ignoring errors when generating the exit code

By default, PHP_CodeSniffer will exit with a non-zero code if any errors or warnings are found. If you want to display errors to the user, but still return with a zero exit code if no warnings are found, you can set the `ignore_errors_on_exit` configuration option. This option is typically used by automated build tools so that a list of errors can be generated without failing the build.

```bash
$ phpcs --config-set ignore_errors_on_exit 1
```

If you want to generate a zero exit code in all cases, additionally set the `ignore_warnings_on_exit` config configuration option.

```bash
$ phpcs --config-set ignore_errors_on_exit 1
$ phpcs --config-set ignore_warnings_on_exit 1
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Ignoring warnings when generating the exit code

By default, PHP_CodeSniffer will exit with a non-zero code if any errors or warnings are found. If you want to display warnings to the user, but still return with a zero exit code if no errors are found, you can set the `ignore_warnings_on_exit` configuration option. This option is typically used by automated build tools so that a list of warnings can be generated without failing the build.

```bash
$ phpcs --config-set ignore_warnings_on_exit 1
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Ignoring non-auto-fixable issues when generating the exit code (PHP_CodeSniffer >= 4.0.0)

By default, PHP_CodeSniffer will exit with a non-zero code if any errors or warnings are found, whether these are auto-fixable or not.
If you want to display non-auto-fixable errors and warnings to the user, but still return with a zero exit code if non-auto-fixable issues are found, you can set the `ignore_non_auto_fixable_on_exit` configuration option.
This option is typically used by automated build tools so that a `phpcbf` run can exit with `0` if it fixed all fixable issues, but there are still some non-auto-fixable issues remaining.

```bash
$ phpcs --config-set ignore_non_auto_fixable_on_exit 1
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Generic Coding Standard Configuration Options

### Setting the path to CSSLint

The `Generic.Debug.CSSLint` sniff will check each CSS file using [CSS Lint](http://csslint.net/). Use the `csslint_path` configuration option to tell the CSSLint sniff where to find the tool.

```bash
$ phpcs --config-set csslint_path /path/to/csslint
```

### Setting the path to the Google Closure Linter

The `Generic.Debug.ClosureLinter` sniff will check each file using the [Google Closure Linter](https://github.com/google/closure-linter), an open source JavaScript style checker from Google. Use the `gjslint_path` configuration option to tell the Google Closure Linter sniff where to find the tool.

```bash
$ phpcs --config-set gjslint_path /path/to/gjslint
```

### Setting the path to PHP

The `Generic.PHP.Syntax` sniff will check the syntax of each PHP file using [the built-in PHP linter](http://php.net/manual/en/features.commandline.options.php). Use the `php_path` configuration option to tell the Syntax sniff where to find the PHP binary.

```bash
$ phpcs --config-set php_path /path/to/php
```

### Setting the path to JSHint

The `Generic.Debug.JSHint` sniff will check each JavaScript file using [JSHint](http://www.jshint.com/), a tool to detect errors and potential problems in JavaScript code. Use the `jshint_path` configuration option to tell the JSHint sniff where to find the tool.

```bash
$ phpcs --config-set jshint_path /path/to/jshint.js
```

As JSHint is just JavaScript code, you may also need to install [Rhino](https://rhino.github.io/) to be able to execute it. Use the `rhino_path` configuration option to tell the JSHint sniff where to find the tool.

```bash
$ phpcs --config-set rhino_path /path/to/rhino
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Squiz Coding Standard Configuration Options

### Setting the path to JSLint

The `Squiz.Debug.JSLint` sniff will check each JavaScript file using [JSLint](http://www.jslint.com/), a JavaScript program that looks for problems in JavaScript programs. Use the `jslint_path` configuration option to tell the JSLint sniff where to find the tool.

```bash
$ phpcs --config-set jslint_path /path/to/jslint.js
```

As JSLint is just JavaScript code, you may also need to install [Rhino](https://rhino.github.io/) to be able to execute it. Use the `rhino_path` configuration option to tell the JSLint sniff where to find the tool.

```bash
$ phpcs --config-set rhino_path /path/to/rhino
```

### Setting the path to JavaScript Lint

The `Squiz.Debug.JavascriptLint` sniff will check each JavaScript file using [JavaScript Lint](http://www.javascriptlint.com/), a tool that checks all your JavaScript source code for common mistakes without actually running the script or opening the web page. Use the `jsl_path` configuration option to tell the JavaScript Lint sniff where to find the tool.

```bash
$ phpcs --config-set jsl_path /path/to/jsl
```

<p align="right"><a href="#table-of-contents">back to top</a></p>


## Zend Coding Standard Configuration Options

### Setting the path to the Zend Code Analyzer

The `Zend.Debug.CodeAnalyzer` sniff will check each file using the Zend Code Analyzer, a tool that comes with Zend Studio. Use the `zend_ca_path` configuration option to tell the Zend Code Analyzer sniff where to find the tool.

```bash
$ phpcs --config-set zend_ca_path /path/to/ZendCodeAnalyzer
```

<p align="right"><a href="#table-of-contents">back to top</a></p>
