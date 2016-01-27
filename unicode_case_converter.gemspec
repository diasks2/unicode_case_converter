# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unicode_case_converter/version'

Gem::Specification.new do |spec|
  spec.name          = "unicode_case_converter"
  spec.version       = UnicodeCaseConverter::VERSION
  spec.authors       = ["Kevin S. Dias"]
  spec.email         = ["diasks2@gmail.com"]

  spec.summary       = %q{Upcase or downcase unicode strings}
  spec.description   = %q{A pure Ruby implementation to upcase and downcase unicode strings}
  spec.homepage      = "https://github.com/diasks2/unicode_case_converter"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "unicode"
  spec.add_development_dependency "activesupport"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "stackprof"
end
