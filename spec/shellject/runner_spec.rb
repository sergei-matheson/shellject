require 'spec_helper'

# Use main module for convenience.
module Shellject
  describe Runner do
    context 'initialised with options and file name' do
      let(:options) do
        { task: :task_name }
      end

      let(:file_name) { %w(one two) }

      subject { Runner.new(options, file_name) }

      context 'when called' do
        let(:task_factory) { instance_double('Shellject::TaskFactory') }
        let(:task) { double('task', call: nil) }

        before do
          allow(TaskFactory).to receive(:new).and_return task_factory
          allow(task_factory).to receive(:create).and_return task
          subject.call
        end

        it 'uses the task factory to create a task based on the task option' do
          expect(task_factory).to have_received(:create).with(
            :task_name, file_name
          )
        end

        it 'calls the task' do
          expect(task).to have_received(:call)
        end
      end
    end
  end
end
