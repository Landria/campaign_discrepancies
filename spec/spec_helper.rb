# frozen_string_literal: true

require 'campaign_discrepancy/checker'
require 'support/campaign'
require 'rspec'
require 'vcr'

VCR.config do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.default_cassette_options = { record: :new_episodes }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.color = true
end
