require 'spec_helper'

# Use main module for convenience.
module Shellject
  describe Tasks::Save do
    context 'when initialised and called with a file name' do
      let(:input_path) { './stuff/my_file.txt' }
      let(:crypto) { instance_double('GPGME::Crypto', encrypt: nil) }
      subject { Tasks::Save.new input_path }

      before do
        allow(GPGME::Crypto).to receive(:new).and_return crypto
        subject.call
      end

      it 'creates a key-trusting crypto' do
        expect(GPGME::Crypto).to have_received(:new).with(always_trust: true)
      end

      it 'encrypts the input file to the correct output file' do
        expect(crypto).to have_received(:encrypt).with(
          input_path,
          output: '~/.shellject/shelljections/my_file.gpg'
        )
      end
    end
  end
end
