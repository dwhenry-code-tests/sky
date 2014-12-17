# TODO: extract to interface gem to allow reuse across services

module Eligible
  CONFIG_PATH = './config/eligible.yml'
  class InvalidAccount < StandardError; end
  class UnknownError < StandardError; end

  extend self

  def check?(account)
    response = Net::HTTP.get_response(url(account))

    case response.code.to_i
    when 404
      raise Eligible::InvalidAccount
    when (200..399)
      response.body == 'CUSTOMER_ELIGIBLE'
    else
      raise Eligible::UnknownError, response.body
    end
  end

  def url(account)
    URI("http://#{config['DOMAIN']}/eligible/#{account}")
  end

  def config
    @config ||= YAML.load(File.read(CONFIG_PATH))
  end

  def reload
    @config = nil
  end
end
