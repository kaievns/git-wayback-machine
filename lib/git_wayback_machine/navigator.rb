module GitWaybackMachine

  class Navigator
    WINDOW_SIZE = 10 # the number of entries to show

    def initialize(history)
      @history       = history
      @current_entry = @history[0]
    end

    def on_change(&block)
      entries_slice.each do |entry|
        if entry == @history[1]
          puts "\e[37;0m#{entry}\e[0m"
        else
          puts "\e[37;2m#{entry}\e[0m"
        end
      end

    rescue Interrupt => e
      nil # that's cool
    ensure
      cleanup!
    end

    def cleanup!
      puts "Cleaning up the mess"
    end

  private

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
