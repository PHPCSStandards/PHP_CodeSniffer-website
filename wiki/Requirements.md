PHP_CodeSniffer 4.x requires PHP 7.2.0 or greater.  
_Prior to PHP_CodeSniffer 4.0.0, the minimum PHP requirement was 5.4.0._

Additionally, PHP_CodeSniffer requires the following PHP extensions to be enabled:
- Tokenizer: used by the core tokenizer to process PHP files
- SimpleXML: used to process ruleset XML files
- XMLWriter: used to create some report formats

Individual sniffs may have additional requirements such as external applications and scripts. See the [Configuration Options](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki/Configuration-Options) manual page for a list of these requirements.
