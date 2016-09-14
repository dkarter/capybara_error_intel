module CapybaraErrorIntel
  module DSL
    def has_selector?(*args)
      matcher = Capybara::RSpecMatchers::HaveSelector.new(*args)
      match_or_error(matcher)
    end

    def has_text?(*args)
      matcher = Capybara::RSpecMatchers::HaveText.new(*args)
      match_or_error(matcher)
    end
    alias_method :has_content?, :has_text?

    def has_title?(title, options = {})
      matcher = Capybara::RSpecMatchers::HaveTitle.new(title, options)
      match_or_error(matcher)
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
