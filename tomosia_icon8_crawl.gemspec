require_relative 'lib/tomosia_icon8_crawl/version'

Gem::Specification.new do |spec|
  spec.name          = "tomosia_icon8_crawl"
  spec.version       = TomosiaIcon8Crawl::VERSION
  spec.authors       = ["ninh-tomosia"]
  spec.email         = ["tt.ninh.le@tomosia.com"]

  spec.summary       = %q{tomosia-icon8-crawl using download image from icon8.com}
  spec.homepage      = "https://github.com/ninh-tomosia/tomosia-icon8-crawl"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "thor"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "writeexcel"
  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "pry"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.

  spec.files         = `git ls-files`.split("\n")
  spec.bindir        = "exe"
  spec.executables   = 'tomosia_icon8_crawl'
  spec.require_paths = ["lib"]
end