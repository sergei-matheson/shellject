module Shellject
  # Runs the the task specified in options
  class Runner
    attr_reader :options, :file_name

    def initialize(options, file_name)
      @options = options
      @file_name = file_name
    end

    def call
      task.call
    end

    private

    def task
      @task = task_factory.create(options[:task], file_name)
    end

    def task_factory
      TaskFactory.new
    end
  end
end
