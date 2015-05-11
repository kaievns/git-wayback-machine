module GitWaybackMachine

  class Engine
    def initialize
      @history   = GitWaybackMachine::History.new
      @navigator = GitWaybackMachine::Navigator.new(@history)

      engage!
    end

    def engage!
      @navigator.on_change { |sha|  move_to sha }
    ensure
      rollback!
    end

    def move_to(entry)
      puts "Moving to #{entry}"
    end

    def rollback!
      move_to @history[0]
      puts "\rWarping back to the reality!"
    end

  end

end
