require 'spec_helper'

# Use main module for convenience.
module Shellject
  describe Tasks::Save do
    context 'when initialised and called with a file name' do
      let(:input_path) { './stuff/my_file.txt' }
      let(:input) { instance_double('File', close: nil) }

      let(:output_path) do
        File.expand_path('~/.shellject/shelljections/my_file.gpg')
      end
      let(:output) { instance_double('File', close: nil) }

      let(:crypto) { instance_double('GPGME::Crypto', encrypt: nil) }
      subject { Tasks::Save.new input_path }

      before do
        allow(GPGME::Crypto).to receive(:new).and_return crypto
        allow(File).to receive(:open).with(input_path).and_return input
        allow(File).to receive(:open).with(output_path, 'wb').and_return output
        subject.call
      end

      it 'creates a key-trusting crypto' do
        expect(GPGME::Crypto).to have_received(:new).with(always_trust: true)
      end

      describe 'input file' do
        it 'is opened for reading' do
          expect(File).to have_received(:open).with(input_path)
        end
        it 'is closed after reading' do
          expect(input).to have_received(:close)
        end
      end

      describe 'output file' do
        it 'is opened for writing' do
          expect(File).to have_received(:open).with(output_path, 'wb')
        end

        it 'is closed after writing' do
          expect(output).to have_received(:close)
        end
      end

      it 'encrypts the input file to the correct output file' do
        expect(crypto).to have_received(:encrypt).with(
          input,
          output: output
        )
      end
    end
  end
end
