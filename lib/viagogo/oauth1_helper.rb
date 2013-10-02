require 'addressable/uri'
require 'cgi'
require 'base64'
require 'openssl'
require 'securerandom'
require 'open-uri'

module OAuth1
  class Helper
    attr_reader :url_params

    def initialize(method, url, params, options)
      options = {
        version: "1.0",
        signature_method: 'HMAC-SHA1',
        timestamp: Time.now.to_i.to_s,
        nonce: SecureRandom.uuid
        # token: ""
      }.merge(options)
      @consumer_secret = options.delete(:consumer_secret)
      @token_secret = options.delete(:token_secret)
      @url_params = params.merge(prepend_oauth_to_key(options))

      @method = method.to_s.upcase
      @url = Addressable::URI.parse(url)
    end

    def signature_base
      @url_params.delete :oauth_signature
      # p @url_params, @url.to_s, url_with_params.query
      [@method, @url.to_s, url_with_params.query].map{|v| CGI.escape(v) }.join('&')
    end

    def append_signature_to_params
      @url_params[:oauth_signature] = hmac_sha1_signature(key, signature_base)
    end

    def full_url
      append_signature_to_params
      url_with_params.to_s
    end

    private
      def key
        @token_secret ? "#{CGI.escape(@consumer_secret)}&#{CGI.escape(@token_secret)}" : "#{CGI.escape(@consumer_secret)}&"
      end

      def url_with_params
        @url.dup.tap{|url| url.query_values = url_params  }
      end

      def prepend_oauth_to_key(options)
        Hash[options.map{|key, value| ["oauth_#{key}".to_sym, value]}]
      end

      def hmac_sha1_signature(key, signature_string)
        digest = OpenSSL::Digest::Digest.new('sha1')
        hmac = OpenSSL::HMAC.digest(digest, key, signature_string)
        Base64.encode64(hmac).chomp.gsub(/\n/, '')
      end
  end
end