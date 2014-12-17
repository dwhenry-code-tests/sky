require 'spec_helper'

describe 'Account access' do
  def app
    RewardsApp
  end

  context 'when customer has rewards' do
    context 'and is eligible for rewards' do
      it 'returns an array contain the award' do
        stub_request(:get, %r{.*/eligible/1234}).to_return(body: 'CUSTOMER_ELIGIBLE')

        get '/rewards/1234', portfolio: 'SPORTS'
        expect(last_response).to be_ok
        expect(last_response.body).to eq ['CHAMPIONS_LEAGUE_FINAL_TICKET'].to_json
      end
    end

    context 'and is not eligible for rewards' do
      it 'returns an empty array of awards' do
        stub_request(:get, %r{.*/eligible/1234}).to_return(body: 'CUSTOMER_INELIGIBLE')

        get '/rewards/1234', portfolio: 'SPORTS'
        expect(last_response).to be_ok
        expect(last_response.body).to eq [].to_json
      end
    end
  end

  context 'when customer has not rewards' do
    it 'returns an empty array of awards' do
      stub_request(:get, %r{.*/eligible/1234}).to_return(body: 'CUSTOMER_ELIGIBLE')

      get '/rewards/1234', portfolio: 'FOO'
      expect(last_response).to be_ok
      expect(last_response.body).to eq [].to_json
    end
  end

  context 'when no portfolio is passed in' do
    it 'returns an empty array of awards' do
      stub_request(:get, %r{.*/eligible/1234}).to_return(body: 'CUSTOMER_ELIGIBLE')

      get '/rewards/1234'
      expect(last_response).to be_ok
      expect(last_response.body).to eq [].to_json
    end
  end

  context 'when account is invalid' do
    it 'returns an empty array of awards' do
      stub_request(:get, %r{.*/eligible/1234}).to_return(status: 404)

      get '/rewards/1234'
      expect(last_response).not_to be_ok
      expect(last_response.status).to eq 404
    end
  end

  context 'when error from eligiblity service' do
    it 'returns an empty array of awards' do
      stub_request(:get, %r{.*/eligible/1234}).to_return(status: 500)

      get '/rewards/1234'
      expect(last_response).to be_ok
      expect(last_response.body).to eq [].to_json
    end
  end

end
