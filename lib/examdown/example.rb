module Examdown
  # An example represents an executable codeblock from a Markdown document. It
  # uses a given element with type `:codeblock` and runs it, returning a new
  # `Kramdown::Element` with the original source code and its output as its
  # value.
  #
  # You can use `Example` to replace a regular codeblock in the Kramdown AST
  # with a self-evaluating one.
  #
  # ## Language modules
  #
  # When code samples are run, the `Example` instance is extended with a module
  # for the language set in the YAML front matter. These modules provide the
  # language-specific implementations to run code.
  #
  # The following languages are supported:
  #
  # * {Sh} for shell scripts
  #
  # ## About YAML front matter
  #
  # YAML front matter is used in code blocks to set additional properties.
  # Refer to {Examdown} for more information.
  #
  # @see Kramdown::Element
  class Example
    extend Forwardable
    def_delegators :element, :value, :attr

    OPTIONS = /\A---\n(.+)\n---\n(.*)\Z/m

    attr_reader :element
    private :element

    # @param element [Kramdown::Element] a code block to run
    def initialize(element)
      @element = element
      extend language_extension if applicable?
    end

    # Whether the source code in the given element will be evaluated or left
    # as-is. Elements without YAML front matter or a language key in it, will
    # be returned as is.
    def applicable?
      value =~ OPTIONS && options.key?('language')
    end

    # @return [Kramdown::Element] the new element with injected output
    def to_element
      return element unless applicable?
      Kramdown::Element.new(element.type, value_with_output, element_attributes)
    end

    private

    def before
      options.fetch('before', [])
    end

    def language
      options.fetch('language')
    end

    def value_with_output
      raw_value
    end

    def language_extension
      Examdown.const_get(language.capitalize)
    end

    def options
      @options ||= YAML.load(value[OPTIONS, 1])
    end

    def raw_value
      @raw_value ||= value[OPTIONS, 2]
    end

    def element_attributes
      attr.merge class: "language-#{language}"
    end
  end
end
