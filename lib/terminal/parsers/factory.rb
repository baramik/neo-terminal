module Terminal
  module Parsers
    SOURCES = [ 'sentinels', 'sniffers', 'loopholes' ]
  
    class Factory
      def self.build(source:, passphrase:)
        if SOURCES.include?(source)
          require_relative "#{source}_parser"
          return Object.const_get("Terminal::Parsers::#{source.capitalize}Parser").new(passphrase: passphrase)
        else
          raise "Source #{source} not found!"
        end
      end
    end
  end
end
