require 'spec_helper'

describe Terminal::Parsers::Factory do
  it { expect(described_class).to respond_to(:build) }

  describe '#build' do
    context 'existing source' do
      it 'instantiates proper factory by source' do
        expect( described_class.build(source: 'sentinels', passphrase: 'blas') ).to be_kind_of(Terminal::Parsers::SentinelsParser)
      end
    end
    
    context 'source does not exist' do
      let(:source) { 'roror' }
  
      it 'raises an exception' do
        expect{ described_class.build(source: source, passphrase: 'blas') }.to raise_exception("Source #{source} not found!")
      end
    end
  end
end