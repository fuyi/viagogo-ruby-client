require "viagogo/version"
require 'viagogo/oauth1_helper'
require 'open-uri'
require 'json'

module Viagogo
  class Client
    
    AUTH_URL = 'http://api.viagogo.net/Public/SimpleOAuthAccessRequest'
    EVENT_ENDPOINT = 'http://api.viagogo.net/Public/Event/Search'
    
    attr_accessor :consumer_key, :consumer_secret, :token, :token_secret

    def initialize(consumer_key, consumer_secret, token = nil, token_secret = nil)
      @consumer_key = consumer_key
      @consumer_secret = consumer_secret
      @token = token
      @token_secret = token_secret
      fetch_public_token unless token_secret # fetch public token if not supplied
      # p @consumer_key
      # p @consumer_secret
      # p @token
      # p @token_secret
    end
    
    def valid_token?
      r = OAuth1::Helper.new('GET', 'http://api.viagogo.net/Public/Category/1', {},{ consumer_key: @consumer_key, consumer_secret: @consumer_secret, token: @token, token_secret: @token_secret})
      request_url = r.full_url
      begin
        open(request_url)
        true
      rescue OpenURI::HTTPError => e
        false
      end
      
    end
    

    def search_events(text)
      # @hrows OpenURI::HTTPError exception when token is not valid
      r = OAuth1::Helper.new('GET', EVENT_ENDPOINT, {searchText:text},{ consumer_key: @consumer_key, consumer_secret: @consumer_secret, token: @token, token_secret: @token_secret})
      request_url  = r.full_url
      open(request_url, 'Content-Type' => 'application/json') do |f|
          json = f.read
          result = JSON.parse(json) if json
          events = result['Results'] if result
      end
    end
    
    def fetch_public_token
      o1 = OAuth1::Helper.new('GET',AUTH_URL, {scope: 'API.Public'},{ consumer_key: @consumer_key, consumer_secret: @consumer_secret})
      auth_url =  o1.full_url
      open(auth_url) do |f|
          str = f.read
          arr = str.split('&')
          token =  arr[0][12..-1]
          token_secret = arr[1][19..-1]
          @token = CGI.unescape(token)
          @token_secret = CGI.unescape(token_secret)
      end
    end
    
    private :fetch_public_token
    
  end
end
