$LOAD_PATH << "../lib"

require_relative '../app'

require 'rspec'
require 'pry-byebug'
require 'rack/test'
require 'webmock/rspec'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
