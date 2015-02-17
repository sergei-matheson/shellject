module Shellject
  module Tasks
    # Loads, decrypts, and outputs a shelljection
    class Load
      attr_reader :save_directory, :name

      def initialize(save_directory, name)
        @save_directory = save_directory
        @name = name
      end

      def call
        ensure_readable
        file = File.open path
        STDOUT.print crypto.decrypt(file)
      ensure
        file.close if file
      end

      private

      def ensure_readable
        fail ShelljectError, "Could not read file #{path}" unless readable?
      end

      def readable?
        path.readable?
      end

      def path
        @path ||= save_directory.path_for name
      end

      def crypto
        GPGME::Crypto.new always_trust: true
      end
    end
  end
end
