require 'capybara_error_intel/version'
require 'capybara_error_intel/dsl'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec/matchers'
require 'rspec'

# Provides Capybara::DSL predicate method wrappers that fail the test with heuristic
# Capybara errors when the result is `false`. Particularly useful when used
# inside page objects, allowing the user to expose predicate methods of their
# own.
module CapybaraErrorIntel
end
