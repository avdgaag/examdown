module Kramdown
  module Parser
    # Specialised Kramdown parser that applies the {Examdown} code runner to
    # codeblocks.
    #
    # @see Examdown::Example
    class Examdown < Kramdown
      include ::Examdown

      def initialize(*args)
        super
        @examdown_cache = Cache.new
      end

      def parse_codeblock
        super.tap do
          last_example = @tree.children.pop
          new_example = Example.new(last_example)
          element =
            if new_example.applicable?
              @examdown_cache.fetch(last_example) do |el|
                Example.new(el).to_element
              end
            else
              last_example
            end
          @tree.children << element
        end
      end
    end
  end
end
