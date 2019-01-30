require 'spec_helper'

describe Terminal::Client do
  subject { described_class.new } 
  let(:passphrase) { 'Kans4s-i$-g01ng-by3-bye' }

  it { is_expected.to respond_to(:get_access_code) }
  it { is_expected.to respond_to(:pull_data) }
  it { is_expected.to respond_to(:push_data) }

  describe 'get_access_code', vcr: true do
    it 'returns a string with access code' do
      expect(subject.get_access_code).to eq('Kans4s-i$-g01ng-by3-bye')
    end
  end

  describe 'pull_data', vcr: true do
    context 'when parameters are valid' do
      it 'responds with 200 code' do
        expect(subject.pull_data(source: 'loopholes', passphrase: passphrase).code).to eq(200)
      end
    end
  end

  describe 'push_data', vcr: true do
    let(:valid_data_item) do 
      Terminal::DataMappers::ZionItem.new(
        source: 'loopholes', 
        start_node: 'gamma', 
        end_node: 'theta', 
        start_time: '2030-12-31T13:00:04Z', 
        end_time: '2030-12-31T13:00:05Z', 
        passphrase: passphrase)
    end
    
    context 'when parameters are valid' do
      it 'responds with 200 code' do
        expect(subject.push_data(data: valid_data_item, passphrase: passphrase).code).to eq(200)
      end
    end
  end 
end