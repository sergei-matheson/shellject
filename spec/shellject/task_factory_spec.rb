require 'spec_helper'

# Use main module for convenience.
module Shellject
  describe TaskFactory do
    context 'when asked to create a task for a name and file name' do
      let(:file_name) { 'one' }
      let(:task) { subject.create name, file_name }

      context "when name is 'load'" do
        let(:name) { :load }
        it 'creates a Load task with the file name' do
          expect(Tasks::Load).to receive(:new).with file_name
          task
        end
      end

      context "when name is 'save'" do
        let(:name) { :save }
        it 'creates a Save task with the file name' do
          expect(Tasks::Save).to receive(:new).with file_name
          task
        end
      end

      context 'when name is unknown' do
        let(:name) { :woot }
        it 'raises hell' do
          expect { task }.to raise_error ShelljectError, "Unknown task 'woot'"
        end
      end
    end
  end
end
