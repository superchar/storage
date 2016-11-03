# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'storage/version'

Gem::Specification.new do |spec|
  spec.name          = "storage"
  spec.version       = Storage::VERSION
  spec.authors       = ["Lobintsev Vladislav"]
  spec.email         = ["vlobyntsev@dataart.com"]
  spec.summary       = %q{This is a gem.}
  spec.description   = %q{This gem imeplements prefix tree. Simple map which can be used to store and access object by key.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir['*.md', 'bin/*', 'lib/**/*.rb']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "5.9.1"
  spec.add_development_dependency "simplecov", "0.12.0"
  spec.add_dependency "zippy", "0.2.3"
end
