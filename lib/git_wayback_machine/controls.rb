module GitWaybackMachine

  class Controls

    def initialize
    end

    def on_event(&callback)
      while true
        case read_key
        when "\e[A"      then callback.call(:up)    # UP
        when "\e[B"      then callback.call(:down)  # DOWN
        when "\r", "\n"  then callback.call(:enter) # ENTER
        when "\u0003", "\e" # Ctrl+C, ESC
          exit(0)
        end
      end
    end

  private

    def read_key
      old_state = `stty -g`
      `stty raw -echo`

      c = STDIN.getc.chr

      if c == "\e" # reading escape sequences
        extra_thread = Thread.new do
          c += STDIN.getc.chr + STDIN.getc.chr
        end
        extra_thread.join(0.001)
        extra_thread.kill
      end

      c

    ensure
      `stty #{old_state}`
    end

  end

end
