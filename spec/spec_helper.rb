require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
# At the top because simplecov needs to watch files being loaded
require 'simplecov'
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
SimpleCov.start do
  add_filter 'spec/'
end
require 'shellject'
