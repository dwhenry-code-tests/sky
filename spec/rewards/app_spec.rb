require 'spec_helper'

describe Rewards::App do
  subject { described_class.new('123', ['SPORTS', 'MOVIES']) }

  it 'raises an error if the account number is not a valid format' do
    pending 'Need to get specification on account format'
    # https://relishapp.com/rspec/rspec-core/v/3-0/docs/pending-and-skipped-examples/pending-examples#`pending`-any-arbitrary-reason-with-a-failing-example
    fail
  end

  it 'checks the account is eligible for rewards' do
    expect(Eligible).to receive(:check?).with('123')

    subject.rewards
  end

  context 'when account is eligible for rewards' do
    before do
      allow(Eligible).to receive(:check?).and_return(true)
    end

    it 'gets the current rewards for the portfolio' do
      expect(Rewards).to receive(:current).and_return({'SPORTS' => 'CHAMPIONS_LEAGUE_FINAL_TICKET'})

      expect(subject.rewards).to eq(['CHAMPIONS_LEAGUE_FINAL_TICKET'])
    end
  end

  context 'when account is not eligible for rewards' do
    before do
      allow(Eligible).to receive(:check?).and_return(false)
    end

    it 'returns an empty array of rewards' do
      expect(subject.rewards).to eq([])
    end
  end

  context 'when the account is invalid' do
    before do
      allow(Eligible).to receive(:check?).and_raise(Eligible::InvalidAccount)
    end

    it 'raise a Rewards::InvalidAccount error' do
      expect do
        subject.rewards
      end.to raise_error(Rewards::InvalidAccount)
    end
  end

  context 'when any other error is returned from the eligible interface' do
    before do
      allow(Eligible).to receive(:check?).and_raise(StandardError)
    end

    it 'returns an empty array of rewards' do
      expect(subject.rewards).to eq([])
    end
  end
end
