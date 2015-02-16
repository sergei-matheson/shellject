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
        file.close
      end

      private

      def path
        File.join(save_directory, basename)
      end

      def basename
        "#{name}.gpg"
      end

      def crypto
        GPGME::Crypto.new always_trust: true
      end

      def save_directory
        File.expand_path '~/.shellject/shelljections'
      end
    end
  end
end
