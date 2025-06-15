# Contributing to the PHP_CodeSniffer documentation

## PHP_CodeSniffer Wiki

For now, the documentation for the PHP_CodeSniffer project is available via the [project Wiki](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki).

### How does the wiki get updated ?

* The source of the Wiki was imported into this repository to maintain the commit history.
* A [GitHub Actions workflow](https://github.com/PHPCSStandards/PHP_CodeSniffer-documentation/blob/main/.github/workflows/publish-wiki.yml) was added to automatically push changes made in the Wiki files in this repository to the upstream Wiki repo.
* Prior to pushing the changes, the workflow will pre-process the files and make the following changes:
    * Replace `{{COMMAND-OUTPUT ...}}` command-line output placeholders with actual command-line output from either `phpcs` or `phpcbf`.
        The code samples used for generating some of this output can be found in the `build/wiki/code-samples` directory.
    * Replace `<!-- START doctoc --> <!-- END doctoc -->` placeholders with a Table of Contents for the page in Markdown.


### Contributing to the Wiki

If you would like to improve the documentation:
1. Fork this repo.
2. Create a new branch off the `main` branch.
3. Make your changes. The Wiki source files are in the `/wiki` subdirectory.
4. Commit your changes with a meaningful commit message.
5. Push your changes to your fork.
6. Submit a pull request from your fork to this repository.
7. Please ensure your pull requests passes all automated CI checks.
8. If you updated anything which will be auto-replaced via the preprocessing:
    * The GitHub Actions workflow will do a "dry-run" for every PR (pre-process, without pushing).
    * Please download the artifact which was created via this dry-run and verify the preprocessing replaced the output in the way you expected.

When in doubt, open an issue first to discuss your change proposal.


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
* The command replacement will not add markdown code fence syntax, so make sure to do this yourself.


#### Running the pre-processing locally

As noted above, you don't _need_ to run the pre-processing locally, a dry-run will be done via GitHub Actions for each PR.
However, if you are making extensive changes, you may still want to test things locally before submitting your PR.

> [!IMPORTANT]
> Run the bash script first, only run the TOC replacement after.

The bash script used for the command replacements can be run locally by invoking:

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


### Frequently Asked Questions

#### Why not make the Wiki publicly editable ?

Publicly editable Wiki pages for big projects get vandalized pretty often and we don't want to risk this type of vandalism leading to users getting incorrect information.

As a secondary reason, there are parts of the wiki (especially the output examples), which were pretty out of date.
By having the wiki source in this repository, it allows for automating certain updates which would otherwise have to be done manually.
