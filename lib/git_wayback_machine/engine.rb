module GitWaybackMachine

  class Engine
    def initialize
      @history   = GitWaybackMachine::History.new
      @navigator = GitWaybackMachine::Navigator.new(@history)
    end

    def start!
      stash!

      @navigator.on_change do |commit|
        move_to commit
      end

    rescue Interrupt => e
      nil # that's cool
    ensure
      rollback!
    end

    def move_to(entry)
      `git reset --hard #{entry.sha}`
    end

    def stash!
      @stash = `git stash -u`
    end

    def rollback!
      puts "\rJumping back to the reality!"
      move_to @history[0]
      `git stash pop` unless @stash.include?("No local changes to save")
    end

  end

end
