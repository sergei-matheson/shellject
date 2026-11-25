# frozen_string_literal: true

require 'spec_helper'

module Shellject
  describe Tasks::SaveAws do
    let(:save_directory) { instance_double('Shellject::SaveDirectory') }
    let(:save_task) { instance_double('Shellject::Tasks::Save', call: nil) }

    around do |example|
      original_environment = Tasks::SaveAws::ENVIRONMENT_VARIABLES.each_with_object({}) do |variable, original|
        original[variable] = ENV[variable] if ENV.key?(variable)
      end
      Tasks::SaveAws::ENVIRONMENT_VARIABLES.each { |variable| ENV.delete(variable) }

      example.run
    ensure
      Tasks::SaveAws::ENVIRONMENT_VARIABLES.each do |variable|
        if original_environment.key?(variable)
          ENV[variable] = original_environment[variable]
        else
          ENV.delete(variable)
        end
      end
    end

    before do
      allow(Tasks::Save).to receive(:new).and_return(save_task)
    end

    it 'saves the available AWS environment variables with shell-safe quoting' do
      ENV['AWS_ACCESS_KEY_ID'] = "access'key"
      ENV['AWS_SECRET_ACCESS_KEY'] = 'secret'
      ENV['AWS_REGION'] = 'us-east-1'

      expect(Tasks::Save).to receive(:new) do |directory, input, name|
        expect(directory).to eq(save_directory)
        expect(input.read).to eq(
          "export AWS_ACCESS_KEY_ID='access'\"'\"'key'\n" \
          "export AWS_SECRET_ACCESS_KEY='secret'\n" \
          "export AWS_REGION='us-east-1'\n"
        )
        expect(name).to eq('aws')
        save_task
      end

      described_class.new(save_directory).call
    end

    it 'uses the requested shelljection name' do
      ENV['AWS_ACCESS_KEY_ID'] = 'access'

      expect(Tasks::Save).to receive(:new).with(
        save_directory,
        instance_of(StringIO),
        'credentials'
      ).and_return(save_task)

      described_class.new(save_directory, 'credentials').call
    end

    it 'does not save when no AWS environment variables are set' do
      expect(Tasks::Save).not_to receive(:new)

      expect { described_class.new(save_directory).call }.to raise_error(
        ShelljectError,
        'No AWS environment variables are set'
      )
    end
  end
end
