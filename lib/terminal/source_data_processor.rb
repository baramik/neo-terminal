require_relative 'client'
require_relative 'file_manager'

module Terminal
  class SourceDataProcessor
    def initialize(source:, credentials:, client: Terminal::Client.new)
      @credentials = credentials
      @source = source
      @client = client
    end

    def fetch
      @response = client.pull_data(source: source, passphrase: credentials)
    end

    def save
      Terminal::FileManager.save(source, response.body)
    end

    def extract
      Terminal::FileManager.unzip(source)
    end

    attr_accessor :response
    attr_reader :source, :credentials, :client
  end 
end