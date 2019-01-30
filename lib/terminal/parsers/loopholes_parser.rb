require_relative 'base_data_parser'

module Terminal
  module Parsers
    class LoopholesParser < Terminal::Parsers::BaseDataParser
      LOCATION = 'tmp/loopholes'
  
      def parse

        node_pairs_data.each_with_object(Array.new) do |node_pair, parsed_data|
          next unless indexed_routes.has_key?(node_pair['id'])

          found_data = indexed_routes[node_pair['id']]
          
          if found_data.kind_of?(Array)
            found_data.each do |route|
              parsed_data << Terminal::DataMappers::ZionItem.new(
                passphrase: passphrase,
                source: 'loopholes', 
                start_node: node_pair['start_node'], 
                end_node: node_pair['end_node'], 
                start_time: route['start_time'], 
                end_time: route['end_time']
              )
            end
          else
            parsed_data << Terminal::DataMappers::ZionItem.new(
              passphrase: passphrase, 
              source: 'loopholes', 
              start_node: node_pair['start_node'], 
              end_node: node_pair['end_node'], 
              start_time: found_data['start_time'], 
              end_time: found_data['end_time']
            )
          end
        end  
      end

      private

      def indexed_routes
        @_node_pairs ||= indexate(hash: routes_data, index_name: 'node_pair_id')
      end

      def node_pairs_data
        @_node_pairs_data ||= load_data(data_source: 'node_pairs')
      end 

      def routes_data
        @_routes_data ||= load_data(data_source: 'routes')
      end
  
      def load_data(data_source:)
        JSON.parse(File.open("#{LOCATION}/#{data_source}.json").read)[data_source]
      end
    end
  end 
end