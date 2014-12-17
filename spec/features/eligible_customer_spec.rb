require 'spec_helper'

describe 'Eligible customer' do
  def app
    RewardsApp
  end

  it 'returns the rewards the customer is entitled to' do
    stub_request(:get, %r{.*/eligible/1234}).to_return(body: 'CUSTOMER_ELIGIBLE')

    get '/rewards/1234?portfolio=SPORTS'
    expect(last_response).to be_ok
    expect(last_response.body).to eq ['CHAMPIONS_LEAGUE_FINAL_TICKET'].to_json
  end
end
