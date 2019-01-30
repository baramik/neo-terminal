require 'httparty'
require_relative 'routes'

module Terminal
  class Client
    include HTTParty
    include Routes
  
    BASE_URL = 'http://challenge.distribusion.com'
     
    def get_access_code
      puts 'Getting access code'
      response = self.class.get(BASE_URL +  access_code_route, headers: default_headers)
      json_response = JSON.parse(response.body)
      json_response['pills']['red']['passphrase']
    end 
  
    def pull_data(source:, passphrase:)
      self.class.get(BASE_URL + zion_route, 
        query: { "source": source, "passphrase": passphrase }, 
        headers: default_headers)
    end

    def push_data(data:, passphrase:)
      resp = self.class.post(BASE_URL + zion_route + "?passphrase=#{passphrase}",
        body: data.to_h, 
        headers: default_headers)
    end

    private

    def default_headers
      { 'Accept' => 'application/json' }
    end
  end 
end