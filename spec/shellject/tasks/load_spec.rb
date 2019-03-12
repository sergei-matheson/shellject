# frozen_string_literal: true

require 'spec_helper'

# Use main module for convenience.
module Shellject
  describe Tasks::Load do
    context 'when initialised and called with a file name' do
      let(:name) { 'my-variables' }
      let(:path) { instance_double('Pathname', readable?: true) }
      let(:file) { instance_double('File', close: nil) }

      let(:crypto) do
        instance_double('GPGME::Crypto', decrypt: 'decrypted content')
      end

      let(:save_directory) do
        instance_double(
          'Shellject::SaveDirectory',
          path_for: path
        )
      end

      subject { Tasks::Load.new save_directory, name }

      before do
        allow(GPGME::Crypto).to receive(:new).and_return crypto
        allow(File).to receive(:open).with(path).and_return file
        allow(STDOUT).to receive(:print)
      end

      it 'creates a key-trusting crypto' do
        expect(GPGME::Crypto).to receive(:new).with(always_trust: true)
        subject.call
      end

      describe 'input file' do
        context 'when not readable' do
          let(:path) do
            instance_double(
              'Pathname', readable?: false, to_s: 'filepath'
            )
          end
          it 'raises an appropriate error' do
            allow(File).to receive(:readable?).and_return false
            expect { subject.call }.to raise_error(
              ShelljectError,
              'Could not read file filepath'
            )
          end
        end
        it 'is determined from the name' do
          expect(save_directory).to receive(:path_for).with(
            name
          )
          subject.call
        end
        it 'is opened for reading' do
          expect(File).to receive(:open).with(path)
          subject.call
        end
        it 'is closed after reading' do
          expect(file).to receive(:close)
          subject.call
        end
      end

      it 'decrypts the file contents' do
        expect(crypto).to receive(:decrypt).with file
        subject.call
      end

      it 'outputs the decrypted contents' do
        expect(STDOUT).to receive(:print).with 'decrypted content'
        subject.call
      end
    end
  end
end
