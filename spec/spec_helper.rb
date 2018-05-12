if ENV['COVERAGE'] =~ /\Atrue\z/i
  require 'simplecov'
  require 'cadre/simplecov'

  SimpleCov.start do
    add_filter '/.bundle/'
    add_filter '/spec/'
    add_filter '/config/'
    add_group 'Libraries', 'lib'
    add_group 'Ignored Code' do |src_file|
      File.readlines(src_file.filename).grep(/:nocov:/).any?
    end
  end

  SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter,
    Cadre::SimpleCov::VimFormatter
  ]

  # SimpleCov.minimum_coverage 95
  SimpleCov.command_name 'Rspec'
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'capybara_error_intel'
require 'capybara/spec/spec_helper'

RSpec.configure do |config|
  Capybara::SpecHelper.configure(config)
end
