require 'gpgme'
require 'fileutils'

require 'shellject/version'
require 'shellject/runner'
require 'shellject/save_directory'
require 'shellject/tasks/load'
require 'shellject/tasks/save'
require 'shellject/task_factory'

# Main module
module Shellject
  # Standard shellject error
  class ShelljectError < StandardError; end
end
