require_relative '../file_manager'
require_relative '../data_mappers/zion_item'

module Terminal
  module Parsers
    class BaseDataParser
      def initialize(passphrase:)
        @passphrase = passphrase
      end  

      def parse
        raise NotImplementedError
      end

      def indexate(hash:, index_name:)
        hash.each_with_object(Hash.new) do |item, indexed|
          next indexed[item[index_name]] = item unless indexed.has_key?(item[index_name])
          if indexed[item[index_name]].kind_of?(Array)
            indexed[item[index_name]] << item
          else
            indexed[item[index_name]] = [ indexed[item[index_name]], item ]
          end
        end  
      end

      private

      attr_reader :passphrase
    end
  end
end

