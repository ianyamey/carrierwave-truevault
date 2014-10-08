# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carrierwave/truevault/version'

Gem::Specification.new do |spec|
  spec.name          = 'carrierwave-truevault'
  spec.version       = Carrierwave::Truevault::VERSION
  spec.authors       = ['Ian Yamey']
  spec.email         = ['ian@gmail.com']
  spec.summary       = 'TrueVault storage with Carrierwave'
  spec.description   = 'Upload files to TrueVault with Carrierwave'
  spec.homepage      = 'https://github.com/ianyamey/carrierwave-truevault'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'carrierwave'
  spec.add_dependency 'rest_client'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
