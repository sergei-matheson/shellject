module Shellject
  module Tasks
    # Loads, decrypts, and outputs a shelljection
    class Load
      def initialize(file_name)
        @file_name = file_name
      end

      def call
        STDOUT.print 'stuff'
      end
    end
  end
end
