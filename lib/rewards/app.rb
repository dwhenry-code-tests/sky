module Rewards
  class InvalidAccount < StandardError; end

  class App
    def initialize(account, portfolio)
      @account = account
      @portfolio = portfolio
    end

    def rewards
      if eligible?
        current = Rewards.current

        @portfolio.map do |channel|
          current[channel]
        end.compact
      else
        []
      end
    end

    private

    def eligible?
      Eligible.check?(@account)
    rescue Eligible::InvalidAccount
      raise Rewards::InvalidAccount
    rescue
      false
    end
  end
end
