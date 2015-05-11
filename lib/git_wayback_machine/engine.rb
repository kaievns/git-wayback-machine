module GitWaybackMachine

  class Engine
    def initialize
      @history   = GitWaybackMachine::History.new
      @navigator = GitWaybackMachine::Navigator.new(@history)
    end

    def start!
      @navigator.on_change do |commit|
        move_to commit
      end

    rescue Interrupt => e
      nil # that's cool
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
