require 'rubygems'
require 'spork'

module AssayerObjectNetwork
  def setup_assayer_objects(num_scenarios = 2, num_items = 3)
    let!(:user) { Factory.create(:user) }
    let!(:assignment) { Factory.create(:rating_assignment, :rater => user) }
    let!(:scenario_family) { assignment.scenario_family }
    let!(:scenarios) { (1..num_scenarios).map { Factory.create(:scenario, :scenario_family => scenario_family) } }
    let!(:scenario) { scenarios.first }
    let!(:items) { scenarios.map { |s| (1..num_items).map { Factory.create(:medical_record_item, :scenario => s) } } }
    let!(:item) { scenario.items.first }
  end
end

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ENV["RAILS_ENV"] ||= 'test'

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  require 'capybara/rspec'
  require 'capybara/rails'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # == Mock Framework
    # config.mock_with :mocha
    config.mock_with :rspec

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # Devise test helpers
    config.include Devise::TestHelpers, :type => :controller
    config.extend ControllerMacros, :type => :controller

    config.extend AssayerObjectNetwork
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  require 'factory_girl_rails'
end
