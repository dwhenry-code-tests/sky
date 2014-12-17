require 'json'
require 'rewards/app'
require 'eligible'
require 'yaml'

module Rewards
  CONFIG_PATH = './config/rewards.yml'

  extend self

  def current
    config['current']
  end

  def reload
    @config = nil
  end

  private

  def config
    @config ||= YAML.load(File.read(CONFIG_PATH))
  end
end
