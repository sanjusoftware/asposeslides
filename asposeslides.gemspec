# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asposeslides/version'

Gem::Specification.new do |spec|
  spec.name          = 'asposeslides'
  spec.version       = Asposeslides::VERSION
  spec.authors       = ['Sanjeev Mishra']
  spec.email         = ['sanjusoftware@gmail.com']
  spec.summary       = %q{A Ruby gem to work with aspose libraries}
  spec.description   = %q{asposeslides is a Ruby gem that can help working with aspose libraries}
  spec.homepage      = 'https://github.com/sanjusoftware/asposeslides'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'rjb', '~> 1.5.2'

end
