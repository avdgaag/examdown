require File.expand_path('../lib/examdown/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'examdown'
  s.version     = Examdown::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Arjan van der Gaag']
  s.email       = %q{arjan@arjanvandergaag.nl}
  s.description = %q{Evaluate code samples in Markdown documents with Kramdown}
  s.homepage    = %q{http://avdgaag.github.com/examdown}
  s.summary     = <<-EOS
Examdown lets you evaluatie inline code examples in your Markdown documents.
Include some special YAML front matter in your examples and Examdown will make
sure its output is included in the code block output.
EOS

  # Files
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # Rdoc
  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = [
     'LICENSE',
     'README.md',
     'HISTORY.md'
  ]

  # Dependencies
  s.add_runtime_dependency 'kramdown'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
end

