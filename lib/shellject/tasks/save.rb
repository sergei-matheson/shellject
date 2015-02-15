module Shellject
  module Tasks
    # Encrypts and saves a shelljection.
    class Save
      attr_reader :input_path

      def initialize(input_path)
        @input_path = input_path
      end

      def call
        from = File.open(input_path)
        to = File.open(output_path, 'wb')
        crypto.encrypt from, output: to
      ensure
        from.close
        to.close
      end

      private

      def output_path
        File.join(save_directory, output_basename)
      end

      def output_basename
        "#{File.basename(input_path, '.*')}.gpg"
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
