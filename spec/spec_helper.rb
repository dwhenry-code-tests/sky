$LOAD_PATH << "../lib"

require_relative '../app'
require 'rewards'
require 'rspec'

require 'pry-byebug'

require 'rack/test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
