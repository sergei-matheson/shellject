module Shellject
  # Factory method for creating crypto instances.
  module CryptoFactory
    def self.create
      GPGME::Crypto.new always_trust: true
    end
  end
end
