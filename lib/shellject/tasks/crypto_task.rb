module Shellject
  module Tasks
    # A task that needs access to a crypto instance
    module CryptoTask
      def crypto
        @crypto ||= CryptoFactory.create
      end
    end
  end
end
