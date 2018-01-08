
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "grpm/version"

Gem::Specification.new do |spec|
  spec.name          = "grpm"
  spec.version       = Grpm::VERSION
  spec.authors       = ["mj"]
  spec.email         = ["tywf91@gmail.com"]

  spec.summary       = %q{grpc proto file manager}
  spec.description   = %q{grpc proto file manager}
  spec.homepage      = "https://github.com/mjason/grpm"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]


  spec.add_dependency "gitlab"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
end
