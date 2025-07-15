# Contributing to the PHP_CodeSniffer documentation

## Table of Contents

* [PHP_CodeSniffer Wiki](#php_codesniffer-wiki)
    * [How does the wiki get updated ?](#how-does-the-wiki-get-updated-)
    * [Contributing to the Wiki](#contributing-to-the-wiki)
    * [Guidelines for updating the wiki files](#guidelines-for-updating-the-wiki-files)
        * [Running the pre-processing locally](#running-the-pre-processing-locally)
        * [Running code quality checks locally](#running-code-quality-checks-locally)
    * [Frequently Asked Questions](#frequently-asked-questions)
        * [Why not make the Wiki publicly editable ?](#why-not-make-the-wiki-publicly-editable-)


## PHP_CodeSniffer Wiki

For now, the documentation for the PHP_CodeSniffer project is available via the [project Wiki](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki).

### How does the wiki get updated ?

* The source of the Wiki was imported into this repository to maintain the commit history.
* A [GitHub Actions workflow](https://github.com/PHPCSStandards/PHP_CodeSniffer-documentation/blob/main/.github/workflows/publish-wiki.yml) was added:
    * It pre-processes the `.md` files to replace placeholders and inject some other content (see [Guidelines for updating the wiki files](#guidelines-for-updating-the-wiki-files)).
    * And then it pushes the resulting updated `.md` files to the upstream Wiki repo.

<p align="right"><a href="#table-of-contents">back to top</a></p>


### Contributing to the Wiki

If you would like to improve the documentation:
1. Fork this repository.
2. Create a new branch off the `main` branch.
3. Make your changes. The Wiki source files are in the `/wiki` subdirectory.
4. Commit your changes with a meaningful commit message.
5. Push your changes to your fork.
6. Submit a pull request from your fork to this repository. This process is documented in more detail in the [GitHub Docs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork).
7. Please ensure your pull requests passes all automated quality checks.
8. If you updated anything which will be auto-replaced via the preprocessing:
    * The GitHub Actions workflow will do a "dry-run" for every PR (pre-process only, no push to the wiki).
    * Please download the artifact which was created via this dry-run and verify the pre-processing replaced the output in the way you expected.

When in doubt, open an issue first to discuss your change proposal.

<p align="right"><a href="#table-of-contents">back to top</a></p>


### Guidelines for updating the wiki files

* Small PRs fixing only one thing will be better received than larger PRs fixing a lot of things in one go.
* Always use fully qualified links. This ensures that the links will work when pages are viewed/edited in this repo, as well as when the pages are viewed from the PHPCS wiki.
* Add table of contents markers if appropriate.
    The start of a page containing a table of contents should look like this:
    ```md
    ## Table of contents

    <!-- START doctoc -->
    <!-- END doctoc -->

    ***

    ... the actual page ...
    ```
* Regarding command replacement markers ...
    * A marker MUST look like `{{COMMAND-OUTPUT ...}}` with `...` being replacement with a quoted `phpcs` or `phpcbf` command.
    * A marker MUST be at the start of a line.
    * A marker MUST be on a line by itself.
    * Commands will be run from the project root directory. Keep this in mind when adding a command replacement marker to a wiki file.
* The command replacement will not add markdown code fence syntax, so make sure to do this yourself.
* If a code sample is needed to generate the desired output, place the code sample in a file in the `build/wiki-code-samples` directory.

<p align="right"><a href="#table-of-contents">back to top</a></p>


#### Running the pre-processing locally

As noted above, you don't _need_ to run the pre-processing locally, a dry-run will be done via GitHub Actions for each PR.
However, if you are making extensive changes, you may still want to test things locally before submitting your PR.

> [!IMPORTANT]
> Run the bash script first, only run the TOC replacement after.

The bash script used for the command replacements can be run locally from the project root directory by invoking:

```bash
build/wiki-command-replacer.sh
```

Notes:
* For the bash script to succeed, the `phpcs` and `phpcbf` commands need to be available in the `PATH` for your OS.
* The bash script will copy the wiki files to the `_wiki` directory before making any replacements to prevent anyone accidentally committing the processed files.

The table of contents generation can be tested locally by installing the `doctoc` tool and running this locally like so:

```bash
npm install -g doctoc
doctoc ./_wiki/ --github --maxlevel 4 --update-only
doctoc ./_wiki/Version-4.0-User-Upgrade-Guide.md --github --maxlevel 3 --update-only
```

Note that this presumes the command replacer has already run and the files have already been copied to the `_wiki` directory.

If you only want to test the TOC generation, make sure you copy the wiki files to the `_wiki` directory before running these commands.

<p align="right"><a href="#table-of-contents">back to top</a></p>


#### Running code quality checks locally

All used code quality checks can be run locally.
Configuration files have been committed to the repository to ensure you will locally get the same results as when the tooling runs in CI.

To run the quality checks locally, install the following tooling:
* [Yamllint](https://github.com/adrienverge/yamllint)
    * [Installation instructions](https://yamllint.readthedocs.io/en/stable/quickstart.html)
    * Run it like so: `yamllint . --format colored --strict --list-files`
* [Actionlint](https://github.com/rhysd/actionlint)
    * [Installation instructions](https://github.com/rhysd/actionlint/blob/main/docs/install.md)
    * Run it like so: `actionlint -verbose`
* [Markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)
    * [Installation instructions](https://github.com/DavidAnson/markdownlint-cli2#install)
    * Run it like so: `markdownlint-cli2`
* [Lychee](https://github.com/lycheeverse/lychee)
    * [Installation instructions](https://github.com/lycheeverse/lychee?tab=readme-ov-file#installation)
    * Run it like so: `lychee "./**/*.md"`
        Note: this command will show "false positives" locally for the `_Sidebar.md` file. These can be ignored.
* [CSpell](https://cspell.org/)
    * [Installation instructions](https://cspell.org/docs/installation)
    * Run it like so: `cspell "**/*.md"`
* [Shellcheck](https://www.shellcheck.net/)
    * [Installation instructions](https://github.com/koalaman/shellcheck?tab=readme-ov-file#installing)
    * Run it like so: `shellcheck ./build/wiki-command-replacer.sh`

<p align="right"><a href="#table-of-contents">back to top</a></p>


### Frequently Asked Questions

#### Why not make the Wiki publicly editable ?

Publicly editable Wiki pages for big projects get vandalized pretty often and we don't want to risk this type of vandalism leading to users getting incorrect information.

As a secondary reason, there are parts of the wiki (especially the output examples), which were pretty out of date.
By having the wiki source in this repository, it allows for automating certain updates which would otherwise have to be done manually.

<p align="right"><a href="#table-of-contents">back to top</a></p>
