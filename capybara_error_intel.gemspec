# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capybara_error_intel/version'

Gem::Specification.new do |spec|
  spec.name          = 'capybara_error_intel'
  spec.version       = CapybaraErrorIntel::VERSION
  spec.authors       = ['Dorian Karter']
  spec.email         = ['jobs@doriankarter.com']

  spec.summary       = 'Provides Capybara\'s heuristic error messages for Page Objects'
  spec.description   = 'Capybara provides excellent error messages for its
                          built in predicate methods: has_selector?, has_text?,
                          has_title? etc.. but when those are used from Page
                          Objects while exposing predicate methods from the
                          PageObjects themselves the error messages are lost
                          and all we get is "expected true, got false".
                          Including this module into your PageObject by adding
                          "include CapybaraErrorIntel::DSL" after
                          "include Capybara::DSL" will return the heuristic
                          error messages.'
  spec.homepage      = 'https://github.com/dkarter/capybara_error_intel'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'sinatra', '~> 1.4', '>= 1.4.7'
  spec.add_development_dependency 'launchy', '~> 0'
  spec.add_development_dependency 'rack', '~> 1.6', '>= 1.6.4'
  spec.add_development_dependency 'rack-test', '~> 0.5', '>= 0.5.4'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'cadre'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'codeclimate-test-reporter'

  spec.add_runtime_dependency 'rspec', '>= 2.1', '< 4.x'
  spec.add_runtime_dependency 'capybara', '~> 2'
end
