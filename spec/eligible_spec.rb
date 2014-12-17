require 'spec_helper'

describe Eligible do
  let(:eligible_yaml) { {'DOMAIN' => 'eligible.sky.com'}.to_yaml }

  before do
    described_class.reload
    allow(File).to receive(:read).and_return(eligible_yaml)
  end

  after do
    described_class.reload
  end

  describe '.url' do
    it 'read the eligible service domain name from the config file' do
      expect(File).to receive(:read).with('./config/eligible.yml')

      expect(described_class.url('123')).to eq(URI('http://eligible.sky.com/eligible/123'))
    end
  end

  describe '.check?' do
    it 'calls to the specified endpoint' do
      expect(Net::HTTP).to receive(:get_response).with(URI('http://eligible.sky.com/eligible/123')).and_return(double(code: '200', body: nil))
      described_class.check?('123')
    end

    context 'when http response is CUSTOMER_ELIGIBLE' do
      let(:response) { double('Net::HTTPResponse', code: '200', body: 'CUSTOMER_ELIGIBLE') }
      before do
        allow(Net::HTTP).to receive(:get_response).and_return(response)
      end

      it 'returns true' do
        expect(subject.check?('123')).to be true
      end
    end

    context 'when http response is CUSTOMER_INELIGIBLE' do
      let(:response) { double('Net::HTTPResponse', code: '200', body: 'CUSTOMER_INELIGIBLE') }
      before do
        allow(Net::HTTP).to receive(:get_response).and_return(response)
      end

      it 'returns true' do
        expect(subject.check?('123')).to be false
      end
    end

    context 'when http response is 404 - Not Found' do
      let(:response) { double('Net::HTTPResponse', code: '404') }
      before do
        allow(Net::HTTP).to receive(:get_response).and_return(response)
      end

      it 'raise InvalidAccount error' do
        expect { subject.check?('123') }.to raise_error(described_class::InvalidAccount)
      end
    end

    context 'when http response is outside valid 2XX and 3XX range' do
      let(:response) { double('Net::HTTPResponse', code: '500', body: 'Error description') }
      before do
        allow(Net::HTTP).to receive(:get_response).and_return(response)
      end

      it 'raise UnknownError error' do
        expect { subject.check?('123') }.to raise_error(described_class::UnknownError)
      end
    end
  end
end
