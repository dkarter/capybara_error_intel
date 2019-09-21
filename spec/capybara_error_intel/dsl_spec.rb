require 'spec_helper'

class Example
  include Capybara::DSL
  include CapybaraErrorIntel::DSL

  def has_selector_test?
    has_selector?(:css, 'h1', text: 'test')
  end

  def has_text_test?
    has_text?('test_text')
  end

  def has_title_test?
    has_title?('test_title')
  end
end

describe CapybaraErrorIntel::DSL do
  describe '#has_selector?' do
    it 'returns heuristic error message when element is not found' do
      expect do
        allow(Capybara).to receive(:current_session) { '<h1>Hello</h1>' }
        expect(Example.new).to have_selector_test
      end.to raise_error(
        /expected to find visible css "h1" with text "test" but there were no matches. Also found "Hello", which matched the selector but not all filters./
      )
    end

    it 'returns true when element is found' do
      allow(Capybara).to receive(:current_session) { '<h1>test</h1>' }
      expect(Example.new).to have_selector_test
    end
  end

  describe '#has_text?' do
    it 'returns heuristic error message when text is not found' do
      subject = Example.new
      allow(Capybara).to receive(:current_session) { '<h1>test</h1>' }
      expect { subject.has_text_test? }.to raise_error(
        RSpec::Expectations::ExpectationNotMetError,
        'expected to find text "test_text" in "test"'
      )
    end

    it 'returns true when text is found' do
      subject = Example.new
      allow(Capybara).to receive(:current_session) { '<h1>test_text</h1>' }
      expect(subject).to have_text_test
    end
  end

  describe '#has_title?' do
    it 'returns heuristic error message when title does not match' do
      subject = Example.new
      allow(Capybara).to receive(:current_session) { '<head><title>test</title></head>' }
      expect { subject.has_title_test? }.to raise_error(
        RSpec::Expectations::ExpectationNotMetError,
        'expected "test" to include "test_title"'
      )
    end

    it 'returns true when title is found' do
      subject = Example.new
      allow(Capybara).to receive(:current_session) { '<head><title>test_title</title></head>' }
      expect(subject).to have_title_test
    end
  end
end
