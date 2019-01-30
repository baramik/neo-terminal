require 'spec_helper'

describe Terminal::DataMappers::ZionItem do
  subject do described_class.new(
              source: 'loopholes', 
              start_node: 'start_node', 
              end_node: 'end_node', 
              start_time: Time.now, 
              end_time: Time.now, 
              passphrase: 'blas ') 
          end
  it { is_expected.to respond_to(:source) }
  it { is_expected.to respond_to(:start_node) }
  it { is_expected.to respond_to(:end_node) }
  it { is_expected.to respond_to(:start_time) }
  it { is_expected.to respond_to(:end_time) }   
  it { is_expected.to respond_to(:to_json) }
  it { is_expected.to respond_to(:passphrase) }
end