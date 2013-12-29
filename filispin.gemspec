# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filispin/version'

Gem::Specification.new do |spec|
  spec.name          = 'filispin'
  spec.version       = Filispin::VERSION
  spec.authors       = ['Vreixo Formoso']
  spec.email         = ['metalpain@gmail.com']
  spec.description   = %q{Simple load and stress testing tool for rails applications}
  spec.summary       = %q{Simple load and stress testing tool for rails applications}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
