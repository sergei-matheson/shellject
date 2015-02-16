require 'spec_helper'

# Use main module for convenience.
module Shellject
  describe Tasks::Load do
    context 'when initialised and called with a file name' do
      let(:name) { 'my-variables' }
      let(:path) do
        File.expand_path('~/.shellject/shelljections/my-variables.gpg')
      end
      let(:file) { instance_double('File', close: nil) }

      let(:crypto) do
        instance_double('GPGME::Crypto', decrypt: 'decrypted content')
      end

      subject { Tasks::Load.new name }

      before do
        allow(GPGME::Crypto).to receive(:new).and_return crypto
        allow(File).to receive(:open).with(path).and_return file
        allow(STDOUT).to receive(:print)
        subject.call
      end

      it 'creates a key-trusting crypto' do
        expect(GPGME::Crypto).to have_received(:new).with(always_trust: true)
      end

      describe 'input file' do
        it 'is opened for reading' do
          expect(File).to have_received(:open).with(path)
        end
        it 'is closed after reading' do
          expect(file).to have_received(:close)
        end
      end

      it 'decrypts the file contents' do
        expect(crypto).to have_received(:decrypt).with file
      end

      it 'outputs the decrypted contents' do
        expect(STDOUT).to have_received(:print).with 'decrypted content'
      end
    end
  end
end
