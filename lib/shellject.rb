require 'fileutils'
require 'pathname'

require 'gpgme'

require 'shellject/version'
require 'shellject/save_directory'
require 'shellject/crypto_factory'
require 'shellject/tasks/crypto_task'
require 'shellject/tasks/load'
require 'shellject/tasks/save'

# Main module
module Shellject
  # Standard shellject error
  class ShelljectError < StandardError; end
end
