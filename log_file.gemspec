# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'log_file/version'

Gem::Specification.new do |spec|
  spec.name          = "log_file"
  spec.version       = LogFile::VERSION
  spec.authors       = ["praveenyoungind"]
  spec.email         = ["praveenyoungind@gmail.com"]
  spec.description   = %q{this is gem is useful to check  the log file data in browser}
  spec.summary       = %q{this gem is useful to check log file data through browser}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
 # spec.add_dependency "kaminari"
end

