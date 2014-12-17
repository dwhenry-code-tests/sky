require 'sinatra'

$LOAD_PATH << './'
require 'rewards'

class RewardsApp < Sinatra::Base
  get '/rewards/:account' do
    begin
      app = Rewards::App.new(params.fetch('account'), params.fetch('portfolio', '').split(','))

      app.rewards.to_json
    rescue Rewards::InvalidAccount
      status 404
    end
  end
end
