require 'spec_helper'

# Use main module for convenience.
module Shellject
  describe Tasks::Load do
    context 'when initialised and called with a file name' do
      let(:file_name) { 'my file' }
      subject { Tasks::Load.new file_name }

      before do
        allow(STDOUT).to receive(:print)
        subject.call
      end

      it 'loads the file from the shelljection dir'
      it 'decrypts the file contents'
      it 'outputs the decrypted contents' do
        expect(STDOUT).to have_received(:print).with 'stuff'
      end
    end
  end
end
