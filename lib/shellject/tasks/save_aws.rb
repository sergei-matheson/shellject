# frozen_string_literal: true

module Shellject
  module Tasks
    # Saves the current AWS credentials and region as a shelljection.
    class SaveAws
      ENVIRONMENT_VARIABLES = %w[
        AWS_ACCESS_KEY_ID
        AWS_SECRET_ACCESS_KEY
        AWS_SESSION_TOKEN
        AWS_SECURITY_TOKEN
        AWS_DEFAULT_REGION
        AWS_REGION
      ].freeze

      def initialize(save_directory, name = nil)
        @save_directory = save_directory
        @name = name || 'aws'
      end

      def call
        exports = ENVIRONMENT_VARIABLES.each_with_object([]) do |variable, lines|
          value = ENV[variable]
          lines << "export #{variable}='#{value.gsub("'", %q('"'"'))}'" unless value.nil?
        end
        raise ShelljectError, 'No AWS environment variables are set' if exports.empty?

        Save.new(@save_directory, StringIO.new("#{exports.join("\n")}\n"), @name).call
      end
    end
  end
end
