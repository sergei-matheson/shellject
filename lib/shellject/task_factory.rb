module Shellject
  # Creates tasks to be run by the runner.
  class TaskFactory
    def initialize
      @task_classes = {
        'save' => Tasks::Save,
        'load' => Tasks::Load
      }
    end

    def create(task_name, file_name)
      task_class(task_name).new(file_name)
    end

    private

    def task_class(task_name)
      @task_classes.fetch(task_name.to_s) do
        fail ShelljectError, "Unknown task '#{task_name}'"
      end
    end
  end
end
