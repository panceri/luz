# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'luz/version'

Gem::Specification.new do |spec|
  spec.name          = "luz"
  spec.version       = Luz::VERSION
  spec.authors       = ["Filipe Sguarizi Panceri"]
  spec.email         = ["filipe.info@gmail.com"]

  spec.summary       = %q{Just a small tool to help calculate products discount}
  spec.description   = %q{Just a small tool to help calculate products discount}
  spec.homepage      = "https://github.com/panceri/luz"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   << 'luz'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "factory_girl", "~> 4.7.0"
  spec.add_development_dependency "simplecov", "~> 0.11.2"
end
