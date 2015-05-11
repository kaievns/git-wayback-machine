module GitWaybackMachine

  class Navigator
    WINDOW_SIZE = 10 # the number of entries to show

    def initialize(history)
      @history       = history
      @current_entry = @history[0]
      @controls      = GitWaybackMachine::Controls.new
    end

    def on_change(&block)
      render

      @controls.on_event do |event|
        case event
        when :up   then @current_entry = prev_entry
        when :down then @current_entry = next_entry
        end

        cleanup
        render
      end

    ensure
      cleanup
    end

    def render
      entries_slice.each do |entry|
        if entry == @current_entry
          puts "\e[37;0m#{entry}\e[0m"
        else
          puts "\e[37;2m#{entry}\e[0m"
        end
      end
    end

    def cleanup
      puts "Cleaning up the mess"
    end

  private

    def prev_entry
      index = @history.index(@current_entry)
      index == 0 ? @current_entry : @history[index-1]
    end

    def next_entry
      index = @history.index(@current_entry)
      index == @history.size-1 ? @current_entry : @history[index+1]
    end

    def entries_slice
      return [] if @history.size == 0

      index = @history.index(@current_entry)
      start = index - WINDOW_SIZE / 2
      start = @history.size - WINDOW_SIZE if start > @history.size - WINDOW_SIZE
      start = 0 if start < 0

      @history.slice(start, WINDOW_SIZE)
    end

  end

end
