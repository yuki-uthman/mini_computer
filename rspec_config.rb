# frozen_string_literal: true

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = %i[should expect] }
  config.fail_fast = true
  config.color = true
end
