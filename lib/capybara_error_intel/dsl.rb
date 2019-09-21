module CapybaraErrorIntel
  # Wraps Capybara::DSL
  module DSL
    def has_selector?(*args)
      matcher = has_selector(*args)
      match_or_error(matcher)
    end

    def has_css?(css, options = {})
      has_selector?(:css, css, options)
    end

    def has_button?(locator, options = {})
      has_selector?(:button, locator, options)
    end

    def has_field?(locator, options = {})
      has_selector?(:field, locator, options)
    end

    def has_xpath?(_xpath, options = {})
      has_selector?(:xpath, locator, options)
    end

    def has_checked_field?(locator, options = {})
      has_selector?(:field, locator, options.merge(checked: true))
    end

    def has_unchecked_field?(locator, options = {})
      has_selector?(:field, locator, options.merge(unchecked: true))
    end

    def has_select?(locator, options = {})
      has_selector?(:select, locator, options)
    end

    def has_table?(locator, options = {})
      has_selector?(:table, locator, options)
    end

    def has_text?(*args)
      matcher = has_text(*args)
      match_or_error(matcher)
    end
    alias has_content? has_text?

    def has_title?(title, options = {})
      matcher = has_title(title, options)
      match_or_error(matcher)
    end

    private

    def has_selector(*args)
      capybara_matcher_module::HaveSelector.new(*args)
    end

    def has_text(*args)
      capybara_matcher_module::HaveText.new(*args)
    end

    def has_title(title, options)
      capybara_matcher_module::HaveTitle.new(title, options)
    end

    def capybara_matcher_module
      if Capybara::VERSION.to_f >= 3.14
        Capybara::RSpecMatchers::Matchers
      else
        Capybara::RSpecMatchers
      end
    end

    def match_or_error(matcher)
      matcher.matches?(Capybara.current_session) || handle_failure(matcher)
    end

    def handle_failure(matcher)
      message = matcher.failure_message

      if matcher.respond_to?(:diffable?) && matcher.diffable?
        RSpec::Expectations.fail_with message, matcher.expected, matcher.actual
      else
        RSpec::Expectations.fail_with message
      end
    end
  end
end
