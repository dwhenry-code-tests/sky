# TODO: extract to interface gem to allow reuse across services

module Eligible
  class InvalidAccount < StandardError; end

  extend self

  def check(account)

  end
end
