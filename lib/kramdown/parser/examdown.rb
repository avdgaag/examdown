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
          element = @examdown_cache.fetch(@tree.children.pop) do |el|
            Example.new(el).to_element
          end
          @tree.children << element
        end
      end
    end
  end
end
