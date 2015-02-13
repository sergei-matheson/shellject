require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'reek/rake/task'
require 'rubocop/rake_task'

Reek::Rake::Task.new do |task|
  task.config_file = './config.reek'
end

begin
  require 'cane/rake_task'

  desc 'Run cane to check quality metrics'
  Cane::RakeTask.new(:quality) do |cane|
    cane.abc_max = 10
    cane.add_threshold 'coverage/.last_run.json', :>=, 100
  end

rescue LoadError
  warn 'cane not available, quality task not provided.'
end

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb', 'spec/**/*.rb']
end

task default: [:spec, :quality, :reek, :rubocop]
