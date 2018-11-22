ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Setup allfixturesin test/fixtures/*.yml for alltestsin alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
