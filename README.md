# Examdown, evaluate code samples in Markdown documents with Kramdown [![Build Status](https://secure.travis-ci.org/avdgaag/examdown.png?branch=master)](http://travis-ci.org/avdgaag/examdown)

## Introduction

Examdown lets you evaluatie inline code examples in your Markdown documents.
Include some special YAML front matter in your examples and Examdown will make
sure its output is included in the code block output.

## Installation

Examdown is distributed as a Ruby gem, which should be installed on most Macs
and Linux systems. Once you have ensured you have a working installation of
Ruby and Ruby gems, install the gem as follows from the command line:

    % gem install examdown

Now you can use the `examdown` input type with the Kramdown Markdown
library from your Ruby scripts:

    require 'kramdown'
    require 'examdown'
    puts Kramdown::Document.new(ARGV[0], input: 'examdown').to_html

## Usage

Examdown takes code blocks in Markdown documents and injects the code's
output back into the original script. This allows you to include examples of
shell scripts in your document and include the dynamically generated output
of those scripts.

### Defining runnable code blocks

Define a regular code block in your Markdown file. Then add some special properties
using YAML front matter:

    Here is some code:

        ---
        language: sh
        ---
        % echo "foo"

    Pretty neat, eh?

This example gets converted to (roughly) the following output:

    <p>Here is some code:</p>

    <pre class="language-sh"><code>% echo "foo"
    foo
    </code></pre>

    <p>Pretty neat, eh?</p>

### YAML front matter options

The following keys are read from the YAML front matter and used:

* `language` defines the language of the code sample and thus how
  it should be run. Currently, only `sh` is accepted as value.
  This value is also added as class name for the wrapper element.
* `before` contains an array of lines of code that should be run
  before the example but not included in the final output.

### Supported languages

See `Example` for a list of supported code runners.

### Examples

#### Specify custom Kramdown parser

    Kramdown::Document.new(content, input: 'examdown').to_html

#### Have code run to include its output

    ---
    language: sh
    ---
    % echo foo

#### Using before steps

    ---
    language: sh
    before:
      - cp /path/to/my-file
    ---
    % cat my-file

## Documentation

See the inline [API docs](http://rubydoc.info/github/avdgaag/examdown/master/frames) for more information.

## Other

### Note on Patches/Pull Requests

1. Fork the project.
2. Make your feature addition or bug fix.
3. Add tests for it. This is important so I don't break it in a future version
   unintentionally.
4. Commit, do not mess with rakefile, version, or history. (if you want to have
   your own version, that is fine but bump version in a commit by itself I can
   ignore when I pull)
5. Send me a pull request. Bonus points for topic branches.

### Issues

Please report any issues, defects or suggestions in the [Github issue
tracker](https://github.com/avdgaag/examdown/issues).

### What has changed?

See the [HISTORY](https://github.com/avdgaag/examdown/blob/master/HISTORY.md) file for a detailed changelog.

### Credits

Created by: Arjan van der Gaag  
URL: [http://arjanvandergaag.nl](http://arjanvandergaag.nl)  
Project homepage: [http://avdgaag.github.com/examdown](http://avdgaag.github.com/examdown)  
Date: november 2013  
License: [MIT-license](https://github.com/avdgaag/examdown/LICENSE) (same as Ruby)
