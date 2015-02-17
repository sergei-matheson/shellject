module Shellject
  # Models the shelljections directory as a repository.
  class SaveDirectory
    attr_reader :path

    def initialize(path)
      @path ||= Pathname.new path
    end

    def path_for(name)
      path.join name
    end
  end
end
