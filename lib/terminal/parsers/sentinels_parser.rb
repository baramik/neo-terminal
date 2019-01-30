require_relative 'base_data_parser'
require_relative '../file_manager'

module Terminal
  module Parsers
    class SentinelsParser < Terminal::Parsers::BaseDataParser
      LOCATION = 'tmp/sentinels'
  
      def parse    
        routes_data.each_with_object(Array.new) do |route, parsed_data|
            parsed_data << Terminal::DataMappers::ZionItem.new(
              source: 'sentinels', 
              start_node: route['node'], 
              end_node: route['node'], 
              start_time: route['time'], 
              end_time: route['time'],
              passphrase: passphrase)
        end
      end

      private 

      def routes
        @_routes ||= indexate(hash: routes_data, index_name: 'route_id')
      end

      def routes_data
        @_routes_data ||= Terminal::FileManager.csv_to_hash(LOCATION, 'routes.csv')
      end
  
    end
  end
end
