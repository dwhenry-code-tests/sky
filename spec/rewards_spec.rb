require 'spec_helper'

describe Rewards do
  after do
    Rewards.reload
  end

  let(:config_yaml) { {'current' => {'SPORTS' => 'CHAMPIONS_LEAGUE_FINAL_TICKET'}}.to_yaml }
  describe '.current' do
    it 'loads values from yml file stored at /config/rewards.yml' do
      expect(File).to receive(:read).with('./config/rewards.yml').and_return(config_yaml)

      Rewards.reload

      expect(Rewards.current).to eq(
        'SPORTS' => 'CHAMPIONS_LEAGUE_FINAL_TICKET'
      )
    end
  end

  describe '.reload' do
    it 'forces the config file to be reloaded from disk' do
      Rewards.reload
      expect(File).to receive(:read).once.and_return(config_yaml)
      Rewards.current
      Rewards.current
    end
  end
end
