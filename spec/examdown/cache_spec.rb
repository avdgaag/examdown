require 'tempfile'
require 'ostruct'

module Examdown
  describe Cache do
    let(:path)    { Tempfile.new('examdown.yml') }
    let(:element) { OpenStruct.new(value: 'foo') }
    subject       { described_class.new(path) }
    after         { File.unlink(path) }

    it 'yields for non-existant keys' do
      expect { |b| subject.fetch(element, &b) }.to yield_control
    end

    it 'does not yield for existing keys' do
      subject.fetch(element) { element }
      expect { |b| subject.fetch(element, &b) }.not_to yield_control
    end

    it 'stores the yielded value' do
      subject.fetch(element) { 'bar' }
      expect(subject.fetch(element)).to eql('bar')
    end

    it 'saves elements to disk' do
      subject.fetch(element) { 'bar' }
      expect(YAML.load_file(path).values).to include('bar')
    end
  end
end
