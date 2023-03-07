require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in non-test mode!') unless Rails.env.test?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'pundit/rspec'
require 'avocado/rspec'
require 'webdrivers/chromedriver'

WebMock.disable_net_connect!({
                               allow_localhost: true,
                               allow: 'chromedriver.storage.googleapis.com'
                             })

Capybara.server = :puma, { Silent: true }

Capybara.register_driver :chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :chrome_headless

ActiveRecord::Migration.maintain_test_schema!

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
#   config.before(:each) do
#     stub_const("TwilioUserClient", FakeTwilioUserClient)
#   end
  config.fixture_path = "#{::Rails.root}/test/fixtures"

  config.global_fixtures = :all

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include Devise::Test::ControllerHelpers, type: :controller

  config.include Capybara::DSL, type: :feature
  config.include Warden::Test::Helpers, type: :feature
  config.include ActionView::Helpers::NumberHelper
  config.include ActiveSupport::Testing::TimeHelpers
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
