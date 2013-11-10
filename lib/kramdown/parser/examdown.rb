module Kramdown
  module Parser
    # Specialised Kramdown parser that applies the {Examdown} code runner to
    # codeblocks.
    #
    # @see Examdown::Example
    class Examdown < Kramdown
      include ::Examdown

      def parse_codeblock
        super.tap do
          @tree.children << Example.new(@tree.children.pop).to_element
        end
      end
    end
  end
end
