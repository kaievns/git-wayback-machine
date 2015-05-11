module GitWaybackMachine

  class Navigator

    def initialize(history)
    end

    def on_change(&block)
      yield "blah!"
    end

  end

end
