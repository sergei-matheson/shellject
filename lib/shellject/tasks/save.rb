module Shellject
  module Tasks
    # Encrypts and saves a file as a shelljection.
    class Save
      include CryptoTask
      attr_reader :save_directory, :input_path, :name

      def initialize(save_directory, input_path, name = nil)
        @save_directory = save_directory
        @input_path = input_path
        @name = name
      end

      def call
        ensure_readable
        ensure_writable
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

      def ensure_writable
        FileUtils.mkdir_p(output_path.parent)
        raise ShelljectError, "Cannot save to #{output_path}" unless writable?
      end

      def writable?
        output_path.parent.writable?
      end

      def ensure_readable
        raise ShelljectError, "Cannot read file #{input_path}" unless readable?
      end

      def readable?
        File.readable? input_path
      end

      def output_path
        @output_path ||= save_directory.path_for name
      end

      def name
        @name ||= File.basename(input_path)
      end
    end
  end
end
