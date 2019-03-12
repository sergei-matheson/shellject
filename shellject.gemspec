# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shellject/version'

Gem::Specification.new do |spec|
  spec.name          = 'shellject'
  spec.version       = Shellject::VERSION
  spec.authors       = ['Sergei Matheson']
  spec.email         = ['sergei.matheson@gmail.com']

  spec.summary       = 'Secure storage and injection of environment variables.'
  spec.description   = 'Store your secret environment variables with GPGME, and inject them into your current shell when needed.'
  spec.homepage      = 'https://github.com/sergei-matheson/shellject'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.post_install_message = <<-eos
Shellject:
  You can get instructions on how to setup your installation with `shellject setup`.
  eos

  spec.add_dependency 'gpgme'
  spec.add_dependency 'clamp'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry', '~> 0.10'

  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'cane'

  spec.add_development_dependency 'codeclimate-test-reporter'
end
