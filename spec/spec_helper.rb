$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'capybara_error_intel'
require 'capybara/spec/spec_helper'

RSpec.configure do |config|
  Capybara::SpecHelper.configure(config)
end
