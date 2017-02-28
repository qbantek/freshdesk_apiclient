# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'freshdesk_apiclient/version'

Gem::Specification.new do |spec|
  spec.name          = 'freshdesk_apiclient'
  spec.version       = FreshdeskApiclient::VERSION
  spec.authors       = ['Erich Quintero']
  spec.email         = ['qbantek@gmail.com']

  spec.summary       = 'A ruby API client for freshdesk.com.'
  spec.homepage      = 'https://github.com/qbantek/freshdesk_apiclient'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.test_files = Dir['spec/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency     'rest-client',  '~> 2.0',   '>= 2.0.1'

  spec.add_development_dependency 'bundler',      '~> 1.14',  '>= 1.14.3'
  spec.add_development_dependency 'gem-release',  '~> 0.7',   '>= 0.7.4'
  spec.add_development_dependency 'rake',         '~> 12.0',  '>= 12.0.0'
  spec.add_development_dependency 'rspec',        '~> 3.5',   '>= 3.5.0'
  spec.add_development_dependency 'rubocop',      '~> 0.47',  '>= 0.47.1'
end
