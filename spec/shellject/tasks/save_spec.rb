require 'spec_helper'

# Use main module for convenience.
module Shellject
  describe Tasks::Save do
    context 'when initialised and called with a save dir and file name' do
      let(:input_path) { './stuff/my_file.sh' }
      let(:input) { instance_double('File', close: nil) }

      let(:output_path) do
        instance_double('Pathname', parent: parent, to_s: 'filename')
      end

      let(:save_directory) do
        instance_double(
          'Shellject::SaveDirectory',
          path_for: output_path
        )
      end

      let(:parent) { instance_double('Pathname', writable?: true) }

      let(:output) { instance_double('File', close: nil) }

      let(:crypto) { instance_double('GPGME::Crypto', encrypt: nil) }

      let(:name) { nil }

      subject { Tasks::Save.new save_directory, input_path, name }

      before do
        allow(FileUtils).to receive(:mkdir_p)
        allow(GPGME::Crypto).to receive(:new).and_return crypto
        allow(File).to receive(:open).with(input_path).and_return input
        allow(File).to receive(:open).with(output_path, 'wb').and_return output
        allow(File).to receive(:readable?).and_return true
      end

      it 'creates a key-trusting crypto' do
        expect(GPGME::Crypto).to receive(:new).with(always_trust: true)
        subject.call
      end

      describe 'input file' do
        context 'when not readable' do
          it 'raises an appropriate error' do
            allow(File).to receive(:readable?).and_return false
            expect { subject.call }.to raise_error(
              ShelljectError,
              "Cannot read file #{input_path}"
            )
          end
        end
        it 'is opened for reading' do
          expect(File).to receive(:open).with(input_path)
          subject.call
        end
        it 'is closed after reading' do
          expect(input).to receive(:close)
          subject.call
        end
      end

      describe 'output file' do
        it 'has its parent directory created' do
          expect(FileUtils).to receive(:mkdir_p).with(parent)
          subject.call
        end

        context 'when parent directory is not writable' do
          let(:parent) { instance_double('Pathname', writable?: false) }
          it 'raises an appropriate error' do
            expect { subject.call }.to raise_error(
              ShelljectError,
              'Cannot save to filename'
            )
          end
        end
        context 'when name is specified' do
          let(:name) { 'woot' }
          it 'is determined from the input path' do
            expect(save_directory).to receive(:path_for).with(
              'woot'
            )
            subject.call
          end
        end

        context 'when name is not specified' do
          let(:name) { nil }

          it 'is determined from the basename of the input path' do
            expect(save_directory).to receive(:path_for).with(
              'my_file.sh'
            )
            subject.call
          end
        end

        it 'is opened for writing' do
          expect(File).to receive(:open).with(output_path, 'wb')
          subject.call
        end

        it 'is closed after writing' do
          expect(output).to receive(:close)
          subject.call
        end
      end

      it 'encrypts the input file to the correct output file' do
        expect(crypto).to receive(:encrypt).with(
          input,
          output: output
        )
        subject.call
      end
    end
  end
end
