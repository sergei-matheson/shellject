module Shellject
  module Tasks
    # Encrypts and saves a shelljection.
    class Save
      attr_reader :input_path

      def initialize(input_path)
        @input_path = input_path
      end

      def call
        ensure_parent
        with_files do |from, to|
          crypto.encrypt from, output: to
        end
      end

      private

      def with_files
        from = File.open(input_path)
        to = File.open(output_path, 'wb')
        yield from, to
      ensure
        from.close if from
        to.close if to
      end

      def ensure_parent
        FileUtils.mkdir_p output_path.parent
      end

      def output_path
        @output_path ||= SaveDirectory.new.path_for input_path
      end

      def crypto
        GPGME::Crypto.new always_trust: true
      end
    end
  end
end
