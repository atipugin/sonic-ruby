lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'sonic/version'

Gem::Specification.new do |spec|
  spec.name = 'sonic-ruby'
  spec.version = Sonic::VERSION
  spec.summary = 'Ruby client for Sonic'
  spec.authors = ['Alexander Tipugin']
  spec.files = `git ls-files -z`.split("\x0").reject { |f|
    f.match(%r{^(test|spec|features)/})
  } - ['.rubocop.yml', '.travis.yml', 'Gemfile.lock', '.gitignore', '.rspec']

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop', '~> 0.66.0'
end
