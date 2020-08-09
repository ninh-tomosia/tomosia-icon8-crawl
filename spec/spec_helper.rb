require "bundler/setup"
require "tomosia_icon8_crawl"

RSpec.configure do |config|

   config.treat_symbols_as_metadata_keys_with_true_values = true
   config.run_all_when_everything_filtered = true
   config.filter_run :focus
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
