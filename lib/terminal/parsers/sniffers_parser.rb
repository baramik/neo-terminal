require_relative 'base_data_parser'
require 'time'
require_relative '../file_manager'

module Terminal
  module Parsers
    class SniffersParser < Terminal::Parsers::BaseDataParser
      LOCATION = 'tmp/sniffers'
  
      def parse
        sequences_data.each_with_object(Array.new) do |sequence, parsed_data|
          node = node_times[sequence['node_time_id']]
          route = routes[sequence['route_id']]
          next unless node
          route['end_time'] = (Time.parse(route['time']) + (node['duration_in_milliseconds'].to_i / 1000)).to_s
            parsed_data << Terminal::DataMappers::ZionItem.new(
              source: 'sniffers', 
              start_node: node['start_node'], 
              end_node: node['end_node'], 
              start_time: route['time'], 
              end_time: route['end_time'], 
              passphrase: passphrase)  
        end         
      end

      private

      def node_times
        @_node_times ||= indexate(hash: node_times_data, index_name: 'node_time_id')
      end

      def routes
        @_routes ||= indexate(hash: routes_data, index_name: 'route_id')
      end

      def routes_data
        @_routes_data ||= Terminal::FileManager.csv_to_hash(LOCATION, 'routes.csv')
      end

      def node_times_data
        @_node_times_data ||= Terminal::FileManager.csv_to_hash(LOCATION, 'node_times.csv')
      end

      def sequences_data
        @_sequences_data ||= Terminal::FileManager.csv_to_hash(LOCATION, 'sequences.csv')
      end
    end
  end
end

