module Shellject
  module Tasks
    # Loads, decrypts, and outputs a shelljection
    class Load
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def call
        file = File.open path
        STDOUT.print crypto.decrypt(file)
      ensure
        file.close if file
      end

      private

      def path
        SaveDirectory.new.path_for name
      end

      def crypto
        GPGME::Crypto.new always_trust: true
      end
    end
  end
end
