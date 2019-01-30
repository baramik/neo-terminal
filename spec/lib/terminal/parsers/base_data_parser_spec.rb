require 'spec_helper'

describe Terminal::Parsers::BaseDataParser do
  subject { described_class.new(passphrase: 'blas') }

  it { is_expected.to respond_to(:parse) }
  it { is_expected.to respond_to(:indexate) }
end