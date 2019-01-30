module Terminal
  module DataMappers
    class ZionItem
      attr_accessor :source, :start_node, :end_node, :start_time, :end_time, :passphrase
  
      def initialize(attributes = {})
        attributes.each do |name, value|
          send("#{name}=", value)
        end
      end
  
      def to_h
        {
          passphrase: passphrase,
          source: source,
          start_node: start_node,
          end_node: end_node,
          start_time: start_time,
          end_time: end_time
        }
      end
      
      def start_time
        parse_time(@start_time)
      end
  
      def end_time
        parse_time(@end_time)
      end
  
      private
  
      def parse_time(time)
        Time.parse(time).strftime("%Y-%m-%dT%H:%M:%S") unless time.nil?
      end
    end
  end
end
