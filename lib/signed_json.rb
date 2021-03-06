require 'json'
require 'signed_json/errors'

module SignedJson
  class Signer

    def initialize(secret, digest = 'SHA1')
      @secret = secret
      @digest = digest
    end

    def encode(input)
      [digest_for(input), input].to_json
    end

    def decode(input)
      digest, data = json_decode(input)
      raise SignatureError unless digest === digest_for(data)
      data
    end

    # Generates an HMAC digest for the JSON representation of the given input.
    # JSON generation must be consistent across platforms.
    # e.g. in Python, specify separators=(',',':') to eliminate whitespace.
    def digest_for(input)
      require 'openssl' unless defined?(OpenSSL) # from ActiveSupport::MessageVerifier
      digest = OpenSSL::Digest::SHA1.new
      ap input
      ap @secret
      OpenSSL::HMAC.hexdigest(digest, @secret, input.to_json)
    end

    private

    def json_decode(input)
      begin
        parts = JSON.parse(input)
      rescue TypeError, JSON::ParserError
        raise InputError
      end

      raise InputError unless
        parts.instance_of?(Array) && parts.length == 2

      parts
    end
  end

end
