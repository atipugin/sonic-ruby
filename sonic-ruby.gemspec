lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'sonic/version'

Gem::Specification.new do |spec|
  spec.name = 'sonic-ruby'
  spec.version = Sonic::VERSION
  spec.summary = 'Ruby client for Sonic'
  spec.authors = ['Alexander Tipugin']

  spec.add_development_dependency 'pry'
end
