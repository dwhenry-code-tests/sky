require 'sinatra'

$LOAD_PATH << './'
require 'rewards'

class RewardsApp < Sinatra::Base
  get '/rewards/:account' do
    app = Rewards::App.new(params[:account], params[:portfolio].split(','))
    app.rewards.to_json
  end
end
