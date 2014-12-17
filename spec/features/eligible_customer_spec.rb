require 'spec_helper'

describe 'Eligible customer' do
  def app
    RewardsApp
  end

  it 'returns the rewards the customer is entitled to' do
    allow(Eligible).to receive(:check).and_return(true)
    allow(Rewards).to receive(:current).and_return({'SPORTS' => 'CHAMPIONS_LEAGUE_FINAL_TICKET'})

    get '/rewards/1234?portfolio=SPORTS'
    expect(last_response).to be_ok
    expect(last_response.body).to eq ['CHAMPIONS_LEAGUE_FINAL_TICKET'].to_json
  end
end
