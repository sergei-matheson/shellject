# frozen_string_literal: true

require 'spec_helper'

# Use main module for convenience.
module Shellject
  describe SaveDirectory do
    context 'when initialised with a directory' do
      subject { SaveDirectory.new('/tmp/shellject') }

      it 'determines the correct file path for a name' do
        expect(subject.path_for('my-vars').to_s).to eql(
          File.expand_path('/tmp/shellject/my-vars')
        )
      end
    end
  end
end
