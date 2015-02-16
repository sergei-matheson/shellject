require 'spec_helper'

# Use main module for convenience.
module Shellject
  describe SaveDirectory do
    it 'determines the correct path for a name' do
      expect(subject.path_for('/tmp/stuff/things/my_file.sh').to_s).to eql(
        File.expand_path('~/.shellject/shelljections/my_file.sh')
      )
    end
  end
end
