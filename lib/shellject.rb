require 'gpgme'

require 'shellject/version'
require 'shellject/runner'
require 'shellject/tasks/load'
require 'shellject/tasks/save'
require 'shellject/task_factory'

# Main module
module Shellject
  # Standard shellject error
  class ShelljectError < StandardError; end
end
