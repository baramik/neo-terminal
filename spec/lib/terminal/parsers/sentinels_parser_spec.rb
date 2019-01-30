require 'spec_helper'

describe Terminal::Parsers::SentinelsParser do
  subject { described_class.new(passphrase: 'Kans4s-i$-g01ng-by3-bye') }

  let(:sentinels_path) { File.join('spec', 'fixtures', 'sentinels') }

  it { is_expected.to respond_to(:parse) }

  describe '.parse' do
    context 'when parsing uploaded data' do
      subject { described_class.new(passphrase: 'Kans4s-i$-g01ng-by3-bye').parse }

      before do
        stub_const('Terminal::Parsers::SentinelsParser::LOCATION', sentinels_path)
      end

      it 'returns an array of parsed data' do
        expect(subject.count).to eq(7)
      end

      it 'contains items of Terminal::DataMappers::ZionItem' do
        expect(subject.first).to be_kind_of(Terminal::DataMappers::ZionItem)
      end 
    end
  end
end