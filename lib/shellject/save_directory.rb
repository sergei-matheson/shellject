module Shellject
  # Models the shelljections directory as a repository.
  class SaveDirectory
    def path_for(name)
      path.join File.basename(name)
    end

    def path
      @path ||= Pathname.new File.expand_path(
        '~/.shellject/shelljections'
      )
    end
  end
end
