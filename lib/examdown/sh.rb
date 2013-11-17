module Examdown
  # Extend an {Example} with the capabilities to run shell scripts, injecting
  # their output below the commands.
  #
  # For example, the following code block in your Markdown document:
  #
  #     ---
  #     language: sh
  #     ---
  #     % echo foo
  #
  # Is output like so:
  #
  #     % echo foo
  #     foo
  #
  # The examples are run in a temporary directory, which will be removed when
  # the example has finished. Any before steps are performed in order. Note
  # that these are run as separate processes. That means that, for example,
  # setting environment variables will not persist to the actual example
  # itself.
  #
  # @see Example
  module Sh
    # Lines beginning with a `%` are considered lines to be executable.
    EXECUTABLE_LINE = /^% (.+)/

    # Runs the example before steps and the executable code in a temporary
    # directory and injects the output from executable lines into the original
    # script.
    #
    # @return [String] original script with output injected
    def value_with_output
      in_tmpdir do
        before.each do |step|
          run step
        end
        raw_value.gsub(EXECUTABLE_LINE) do |match|
          output = run($1)
          output = "\n#{output}" if output =~ /\S/
          match + output
        end
      end
    end

    private

    def in_tmpdir
      Dir.mktmpdir do |path|
        old_path = Dir.pwd
        Dir.chdir(path)
        ret = yield
        Dir.chdir(old_path)
        ret
      end
    end

    def run(cmd)
      `#{cmd} 2>&1`.chomp
    end
  end
end
