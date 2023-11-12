PHP_CodeSniffer is a set of two PHP scripts:
1. the main [`phpcs` script](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki/Usage) that tokenizes PHP, JavaScript and CSS files to detect violations of a defined coding standard; and
2. a [`phpcbf` script](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki/Fixing-Errors-Automatically) to automatically correct detected coding standard violations.

PHP_CodeSniffer is an essential development tool that ensures your code remains clean and consistent.

A coding standard in PHP_CodeSniffer is a collection of sniff files. Each sniff file checks one part of the coding standard only. Each sniff can yield multiple error codes, a different one for each aspect of the code which was checked and found non-compliant.

Multiple coding standards can be used within PHP_CodeSniffer so that the one installation can be used across multiple projects.  
As of PHP_CodeSniffer 4.0.0, the default coding standard used by PHP_CodeSniffer is the PSR12 coding standard (previously, this was the PEAR standard).

## Example

To check a file against the PSR12 coding standard, simply specify the file's location.

```bash
$ phpcs path/to/code/fileA.php
{{COMMAND-OUTPUT "phpcs --parallel=1 --no-cache --no-colors --report-width=100 --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code/fileA.php"}}
```

Or, if you wish to check an entire directory, you can specify the directory location instead of a file.

```bash
$ phpcs /path/to/code
{{COMMAND-OUTPUT "phpcs --parallel=1 --no-cache --no-colors --report-width=100 --basepath=build/wiki-code-samples build/wiki-code-samples/path/to/code"}}
```
