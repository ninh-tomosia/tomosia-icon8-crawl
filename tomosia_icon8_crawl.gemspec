require_relative 'lib/tomosia_icon8_crawl/version'

Gem::Specification.new do |spec|
  spec.name          = "tomosia_icon8_crawl"
  spec.version       = TomosiaIcon8Crawl::VERSION
  spec.authors       = ["ninh-tomosia"]
  spec.email         = ["tt.ninh.le@tomosia.com"]

  spec.summary       = %q{tomosia-icon8-crawl using download image from icons8.com}
  spec.homepage      = "https://github.com/ninh-tomosia/tomosia-icon8-crawl"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "thor", '~> 1.0', '>= 1.0.1'
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "httparty", '~> 0.17.3'
  spec.add_runtime_dependency "writeexcel", '~> 1.0', '>= 1.0.5'
  spec.add_runtime_dependency "nokogiri", '~> 1.10', '>= 1.10.10'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.

  spec.files         = `git ls-files`.split("\n")
  spec.bindir        = "exe"
  spec.executables   = 'tomosia_icon8_crawl'
  spec.require_paths = ["lib"]
end