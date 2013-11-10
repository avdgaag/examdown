require 'yaml'
require 'forwardable'
require 'tmpdir'
require 'kramdown'

require 'examdown/version'
require 'examdown/sh'
require 'examdown/example'
require 'kramdown/parser/examdown'

# Examdown takes code blocks in Markdown documents and injects the code's
# output back into the original script. This allows you to include examples of
# shell scripts in your document and include the dynamically generated output
# of those scripts.
#
# ## Defining runnable code blocks
#
# Define a regular code block in your Markdown file. Then add some special properties
# using YAML front matter:
#
#     Here is some code:
#
#         ---
#         language: sh
#         ---
#         % echo "foo"
#
#     Pretty neat, eh?
#
# This example gets converted to (roughly) the following output:
#
#     <p>Here is some code:</p>
#
#     <pre class="language-sh"><code>% echo "foo"
#     foo
#     </code></pre>
#
#     <p>Pretty neat, eh?</p>
#
# ## YAML front matter options
#
# The following keys are read from the YAML front matter and used:
#
# * `language` defines the language of the code sample and thus how
#   it should be run. Currently, only `sh` is accepted as value.
#   This value is also added as class name for the wrapper element.
# * `before` contains an array of lines of code that should be run
#   before the example but not included in the final output.
#
# ## Supported languages
#
# See {Example} for a list of supported code runners.
#
# @example Specify custom Kramdown parser
#   Kramdown::Document.new(content, input: 'examdown').to_html
#
# @example Have code run to include its output
#   ---
#   language: sh
#   ---
#   % echo foo
#
# @example Using before steps
#   ---
#   language: sh
#   before:
#     - cp /path/to/my-file
#   ---
#   % cat my-file
#
module Examdown
end
