require 'spec_helper'

describe Terminal::Parsers::LoopholesParser do
  subject { described_class.new(passphrase: 'Kans4s-i$-g01ng-by3-bye') }

  let(:loopholes_path) { File.join('spec', 'fixtures', 'loopholes') }

  it { is_expected.to respond_to(:parse) }

  describe '.parse' do
    context 'when parsing uploaded data' do
      subject { described_class.new(passphrase: 'Kans4s-i$-g01ng-by3-bye').parse }

      before do
        stub_const('Terminal::Parsers::LoopholesParser::LOCATION', loopholes_path)
      end

      it 'returns an array of parsed data' do
        expect(subject.count).to eq(4)
      end

      it 'contains items of Terminal::DataMappers::ZionItem' do
        expect(subject.first).to be_kind_of(Terminal::DataMappers::ZionItem)
      end 
    end
  end
end