module GitWaybackMachine

  def self.boot
    Engine.new.tap do |engine|
      engine.read_history
      engine.engage_navigator
    end
  end

end

require_relative "./git_wayback_machine/version"
require_relative "./git_wayback_machine/engine"
require_relative "./git_wayback_machine/history"
require_relative "./git_wayback_machine/navigator"
