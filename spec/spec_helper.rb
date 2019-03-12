# frozen_string_literal: true

# At the top because simplecov needs to watch files being loaded
require 'simplecov'
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
SimpleCov.start do
  add_filter 'spec/'
end
require 'shellject'
