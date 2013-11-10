module Examdown
  describe Example do
    subject { described_class.new(element) }
    let(:element) { Kramdown::Element.new(:codeblock, value) }

    context 'given a plain code sample' do
      let(:value) { 'foo' }

      it 'does not alter plain code samples' do
        expect(subject).to_not be_applicable
      end

      it 'returns the original element' do
        expect(subject.to_element).to be element
      end
    end

    context 'given a code sample with invalid YAML front matter' do
      let(:value) { "---\nfoo: bar\n---\nfoo" }

      it 'is not applicable' do
        expect(subject).not_to be_applicable
      end
    end

    context 'given a code sample with valid YAML front matter' do
      let(:value) { "---\nlanguage: sh\n---\n% echo foo" }

      it 'is applicable' do
        expect(subject).to be_applicable
      end

      it 'generates a new element with evaluated code' do
        el = subject.to_element
        expect(el.value).to eql("% echo foo\nfoo")
      end

      it 'sets the language class' do
        el = subject.to_element
        expect(el.attr).to include(class: 'language-sh')
      end
    end

    context 'given a code sample with an unknown language' do
      let(:value) { "---\nlanguage: bla\n---\nfoo" }

      it 'raises an exception' do
        expect { subject.to_element }.to raise_error
      end
    end

    context 'given a code sample with a before block' do
      let(:value) { "---\nlanguage: sh\nbefore:\n  - echo foo > bar\n---\n% cat bar" }

      it 'runs the before block before the actual example' do
        expect(subject.to_element.value).to eql("% cat bar\nfoo")
      end
    end
  end
end
