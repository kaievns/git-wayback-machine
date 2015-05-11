module GitWaybackMachine

  class Navigator

    def initialize(history)
      puts history.inspect
    end

    def on_change(&block)
      yield "blah!"
    end

  end

end
