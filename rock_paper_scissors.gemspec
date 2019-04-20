
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rock_paper_scissors/version"

Gem::Specification.new do |spec|
  spec.name          = "rock_paper_scissors"
  spec.version       = RockPaperScissors::VERSION
  spec.authors       = "Rajas Pargaonkar"
  spec.email         = "rajas@waddleworks.com"

  spec.summary       = %q{A simple game of rock paper scissors}
  spec.description   = %q{See the summary}
  spec.homepage      = %q{https://github.com/rajastakilos/rock-paper-scissors}
  spec.license       = %q{MIT}

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/rajastakilos/rock-paper-scissors"
    spec.metadata["changelog_uri"] = "http://github.com/rajastakilos/rock-paper-scissors"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ["game_start"]  
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
