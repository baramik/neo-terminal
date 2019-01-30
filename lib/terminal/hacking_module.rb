require_relative 'source_data_processor'
require_relative 'client'
require_relative 'parsers/factory'
require_relative 'parsers/base_data_parser'

module Terminal
  module HackingModule
    SOURCES = [ 'sentinels', 'loopholes', 'sniffers' ]
  
    def pull_data
      SOURCES.each do |source|
        puts "Accessing #{source} data..."

        data_processor = Terminal::SourceDataProcessor.new(source: source, credentials: passphrase, client: terminal_client)
        data_processor.fetch
        data_processor.save
        data_processor.extract
      end
      puts "Done!"
    end
    
    def parse_data
      puts 'Parsing data...'
      parsed_data = Array.new
      SOURCES.each do |source|
        data_parser = Terminal::Parsers::Factory.build(source: source, passphrase: passphrase)
        parsed_data << data_parser.parse
      end
      puts 'Done!'
      return parsed_data.flatten
    end
  
    def push_data(data:)
      puts 'Pushing data!'
      data.each do |output|
        resp = terminal_client.push_data(data: output, passphrase: passphrase)
        if resp.code == 200 || resp.code == 201
          puts 'data successfully sent!'
        end
      end
      puts 'Done!'
    end

    private

    def passphrase
      @_passphrase ||= terminal_client.get_access_code
    end
  
    def terminal_client
      @_terminal_client ||= Terminal::Client.new
    end 
  end
end