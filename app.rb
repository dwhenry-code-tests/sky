require 'sinatra'

class RewardsApp < Sinatra::Base
  get '/rewards/:account' do
    ["CHAMPIONS_LEAGUE_FINAL_TICKET"].to_json
  end
end
