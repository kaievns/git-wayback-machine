module GitWaybackMachine

  class Engine

    def read_history
      puts "Reading the history!"
      @history = GitWaybackMachine::History.new
    end

    def engage_navigator
      GitWaybackMachine::Navigator.new(@history).on_change do |sha|
        move_to sha
      end

    rescue Interrupt => e
      nil # that's cool
    ensure
      rollback!
    end

    def move_to(sha)
      puts "Moving to #{sha}"
    end

    def rollback!
      puts "\rWarping back to the reality!"
    end

  end

end
